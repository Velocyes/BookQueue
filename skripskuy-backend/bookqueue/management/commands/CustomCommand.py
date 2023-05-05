import datetime

from django.core.management.base import BaseCommand
from django.db.models import F, Sum, OuterRef, Subquery, Count
from django.db.models.functions import Coalesce

from bookqueue.models import *


class Command(BaseCommand):
    @staticmethod
    def get_today_total_order(order_status=None):
        return Order.objects.filter(
            service__id=OuterRef('service__id'),
            order_status=order_status,
            date__range=[datetime.date.today().replace(day=1), datetime.date.today()]
        ).values('service__id').annotate(
            total_order=Count('service__id')
        ).values('total_order')[:1]

    def handle(self, *args, **options):
        total_today_queue = Order.objects.filter(
            service__id=1,
            date=datetime.date.today(),
        ).values('service__id').annotate(
            current_queue_index=Coalesce(Subquery(
                OrderQueue.objects.filter(service__id=OuterRef('service__id')).values('index')[:1]), 0),
            total_queue=Count('service__id')
        )

        this_month_order_statistic = Order.objects.filter(
            service__id=1,
            date__range=[datetime.date.today().replace(day=1), datetime.date.today()]
        ).values('service__id').annotate(
            total_cancelled_order=Subquery(
                Order.objects.filter(
                    service__id=OuterRef('service__id'),
                    order_status=OrderStatus.DIBATALKAN,
                    date__range=[datetime.date.today().replace(day=1), datetime.date.today()]
                ).values('service__id').annotate(
                    total_cancelled_order=Count('service__id')
                ).values('total_cancelled_order')[:1]
            ),
            total_order=Count('service__id'),
        )

        today_order_statistic = Order.objects.filter(
            service__id=1,
            date=datetime.date.today()
        ).values('service__id').annotate(
            total_cancelled_order=Coalesce(Subquery(self.get_today_total_order(order_status=OrderStatus.BELUM_DIKERJAKAN)), 0),
            total_on_progress_order=Coalesce(Subquery(self.get_today_total_order(order_status=OrderStatus.SEDANG_DIKERJAKAN)), 0),
            total_done_order=Coalesce(Subquery(self.get_today_total_order(order_status=OrderStatus.SELESAI)), 0),
            total_paid_order=Coalesce(Subquery(self.get_today_total_order(order_status=OrderStatus.DIBAYAR)), 0),
        )[:1]

        total_today_income = Order.objects.filter(
            service__id=1,
            # date__range=[datetime.date.today().replace(day=1), datetime.date.today()]
        ).values('service__id').annotate(
            total_income=Sum(Coalesce(F('orderdetail__quantity'), 1) * Coalesce(F('orderdetail__cost'), 0))
        )[:1]

        this_month_income = Order.objects.filter(
            service__id=1,
            date__range=[datetime.date.today().replace(day=1), datetime.date.today()]
        ).values('service__id').annotate(
            total_income=Sum(Coalesce(F('orderdetail__quantity'), 1) * Coalesce(F('orderdetail__cost'), 0))
        )

        for qs1, qs2, qs3, qs4, qs5 in zip(total_today_queue, this_month_order_statistic, today_order_statistic, total_today_income, this_month_income):
            print(qs1),
            print(qs2),
            print(qs3),
            print(qs4)
            print(qs5)
