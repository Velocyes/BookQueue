from datetime import date

from django.db import transaction
from django.db.models import F, Q, Avg, Count, OuterRef, Subquery, Sum
from django.db.models.functions import Coalesce
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response

from firebase import push_notification
from .serializers import *


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = ['firebase_id', 'firebase_token', 'user_role', 'url_photo', 'full_name', 'phone_number', 'email',
                        'created_at', 'updated_at']
    ordering_fields = ['firebase_id', 'firebase_token', 'user_role', 'url_photo', 'full_name', 'phone_number', 'email',
                       'created_at', 'updated_at']
    search_fields = ['firebase_id', 'firebase_token', 'user_role', 'url_photo', 'full_name', 'phone_number', 'email',
                     'created_at', 'updated_at']

    @action(detail=False, methods=['post'], url_path='createUser')
    def create_user(self, request):
        try:
            with transaction.atomic():
                serializer = UserSerializer(data=request.data)
                if serializer.is_valid():
                    serializer.save()
                    return Response(status=status.HTTP_201_CREATED)
                else:
                    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(e)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['patch'], url_path='updateUser')
    def update_user(self, request):
        try:
            with transaction.atomic():
                firebase_id = self.request.query_params.get('firebase_id', default=None)
                if firebase_id is not None:
                    user = User.objects.filter(
                        firebase_id=firebase_id
                    )
                    if user.exists():
                        serializer = UserSerializer(user.get(), data=request.data, partial=True)
                        if serializer.is_valid():
                            serializer.save()
                            return Response(status=status.HTTP_200_OK)
                        else:
                            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                    else:
                        return Response([], status=status.HTTP_404_NOT_FOUND)
                else:
                    return Response(status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(e)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['post'], url_path='pushNotification')
    def push_notification(self, request):
        try:
            data = request.data
            user_id = self.request.query_params.get('user_id', default=None)
            if user_id is not None:
                user = User.objects.filter(
                    firebase_id=user_id
                ).values()
                if user.exists():
                    push_notification(device_token=user[0]['firebase_token'],
                                      title=data['title'] if 'title' in data else None,
                                      body=data['body'] if 'body' in data else None)
                else:
                    return Response([], status=status.HTTP_404_NOT_FOUND)
            else:
                users = User.objects.all().values()
                if users.exists():
                    for user in users:
                        push_notification(device_token=user['firebase_token'],
                                          title=data['title'] if 'title' in data else None,
                                          body=data['body'] if 'body' in data else None)
            return Response(status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST)


class ServiceViewSet(viewsets.ModelViewSet):
    queryset = Service.objects.all()
    serializer_class = ServiceSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = ['user__firebase_id', 'is_open', 'vehicle_type']
    ordering_fields = ['user', 'name', 'address', 'vehicle_type', 'description', 'is_open', 'open_hour', 'close_hour',
                       'created_at', 'updated_at']
    search_fields = ['name', 'address']

    @action(detail=False, methods=['post'], url_path='createService')
    def create_service(self, request):
        try:
            with transaction.atomic():
                serializer = ServiceSerializer(data=request.data)
                if serializer.is_valid():
                    serializer.save()
                    user = User.objects.all().filter(firebase_id=serializer.data['user']).get()
                    push_notification(user.firebase_token)
                    return Response(data=serializer.data, status=status.HTTP_201_CREATED)
                else:
                    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(e)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['patch'], url_path='updateServiceStatus')
    def update_service_status(self, request):
        try:
            with transaction.atomic():
                service_id = self.request.query_params.get('service_id', default=None)
                if service_id is not None:
                    order = self.queryset.filter(
                        id=service_id
                    )
                    if order.exists():
                        serializer = ServiceSerializer(order.get(), data=request.data, partial=True)
                        if serializer.is_valid():
                            order_queue = OrderQueue.objects.filter(
                                service_id=service_id
                            ).order_by('-date')

                            if order_queue.exists():
                                order_queue = order_queue.get()
                                if order_queue.date < date.today():
                                    order_queue.index = 1
                                    order_queue.date = date.today()
                                    order_queue.save()
                            else:
                                OrderQueue(service_id=service_id, index=1, date=date.today()).save()

                            serializer.save()

                            # for user in User.objects.all().filter(~Q(firebase_id=serializer.data['user'])):
                            #     push_notification(user.firebase_token)
                            return Response(serializer.data, status=status.HTTP_200_OK)
                        else:
                            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                    else:
                        return Response([], status=status.HTTP_200_OK)
                else:
                    return Response(status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getService')
    def get_service(self, request):
        pk = self.request.query_params.get('id', default=None)
        keyword = self.request.query_params.get('search')
        vehicle_type = self.request.query_params.get('vehicle_type__name')
        if pk is None:
            queryset = self.queryset.filter(
                Q(vehicle_type__name__icontains=vehicle_type if vehicle_type is not None else "")
            ).filter(
                Q(name__icontains=keyword if keyword is not None else "") |
                Q(address__icontains=keyword if keyword is not None else "") |
                Q(city__name__icontains=keyword if keyword is not None else "") |
                Q(vehicle_type__name__icontains=keyword if keyword is not None else "")
            )
        else:
            if pk != "":
                queryset = self.queryset.filter(
                    id=pk
                )
            else:
                return Response(status=status.HTTP_400_BAD_REQUEST)
        queryset = queryset.annotate(
            phone_number=F('user__phone_number'),
            avg_rating=Coalesce(Avg('review__rating'), 0.0),
            total_rating=Count('review')
        ).values()
        return Response(queryset)

    @action(detail=False, methods=['get'], url_path='getExploreServiceJson')
    def get_explore_service_json(self, request):
        keyword = self.request.query_params.get('keyword', default=None)
        vehicle_type = int(self.request.query_params.get('vehicle_type', default=None))
        try:
            qs = self.queryset
            if vehicle_type != 0:
                qs = self.queryset.filter(
                    vehicle_type__in=[vehicle_type if vehicle_type is not None else 0, 0]
                )
            if keyword != "":
                qs = qs.filter(
                    Q(name__icontains=keyword if keyword is not None else "") |
                    Q(address__icontains=keyword if keyword is not None else "")
                )
            qs = qs.annotate(
                user_phone_number=F('user__phone_number'),
                avg_rating=Coalesce(Avg('review__rating'), 0.0),
                total_rating=Count('review')
            ).values('id', 'user', 'profile_picture', 'name', 'address', 'vehicle_type', 'description', 'is_open',
                     'open_hour', 'close_hour', 'user__phone_number', 'avg_rating', 'total_rating')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getServiceDetailJson')
    def get_service_detail_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                id=service_id
            ).annotate(
                user_phone_number=F('user__phone_number'),
                avg_rating=Coalesce(Avg('review__rating'), 0.0),
                total_rating=Count('review')
            ).values('id', 'user', 'profile_picture', 'name', 'address', 'vehicle_type', 'description', 'is_open',
                     'open_hour', 'close_hour', 'user_phone_number', 'avg_rating', 'total_rating')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)


class ServicePackageViewSet(viewsets.ModelViewSet):
    queryset = ServicePackage.objects.all()
    serializer_class = ServicePackageSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = ['service__id']
    ordering_fields = '__all__'
    search_fields = '__all__'


class ReviewViewSet(viewsets.ModelViewSet):
    queryset = Review.objects.all()
    serializer_class = ReviewSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = ['id', 'service__id']
    ordering_fields = '__all__'
    search_fields = '__all__'
    ordering = ['created_at']

    @action(detail=False, methods=['get'], url_path='getReviewByServiceId')
    def get_review_by_service_id(self, request):
        try:
            service_id = self.request.query_params.get('service_id', default=None)
            qs = self.queryset.filter(
                service__id=service_id if service_id is not None else 0
            ).annotate(
                plate_number=F('order__plate_number'),
                service_name=F('service__name'),
                user_full_name=F('user__full_name'),
                user_profile_picture=Subquery(
                    User.objects.filter(firebase_id=OuterRef('user__firebase_id'))[:1].values('profile_picture'))
            ).values('service', 'service_name', 'plate_number', 'user', 'date', 'rating', 'description',
                     'user_full_name', 'user_profile_picture')

            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)


class OperationalServiceViewSet(viewsets.ModelViewSet):
    queryset = OperationalService.objects.all()
    serializer_class = OperationalServiceSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = ['service__id']
    ordering_fields = '__all__'
    search_fields = '__all__'

    ordering = ['day']


class OrderViewSet(viewsets.ModelViewSet):
    queryset = Order.objects.all()
    serializer_class = OrderSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = '__all__'
    ordering_fields = '__all__'
    search_fields = '__all__'

    @staticmethod
    def notify_user_about_queue(serializer):
        orders = Order.objects.filter(
            service__id=serializer.data['service'],
            order_status=OrderStatus.BELUM_DIKERJAKAN,
            date=date.today(),
        ).annotate(
            user_firebase_token=F('user__firebase_token'),
            queue_number_difference=F('index') - F('service__orderqueue__index'),
        ).filter(
            queue_number_difference__lte=5
        ).values()
        for order in orders:
            if 5 >= order['queue_number_difference'] >= 1:
                push_notification(device_token=order['user_firebase_token'], title="Pemberitahuan",
                                  body=f"Terdapat {order['queue_number_difference']} antrian lagi sebelum kamu")
            elif order['queue_number_difference'] == 0:
                push_notification(device_token=order['user_firebase_token'], title="Pemberitahuan",
                                  body=f"Sekarang adalah giliran kamu")

    @staticmethod
    def get_total_order():
        qs = Order.objects.filter(
            service__id=OuterRef('service__id'),
            date=OuterRef('date'),
            order_status__name=OuterRef('order_status__name')
        ).values('service__id').annotate(
            total_order=Coalesce(Count('service__id'), 0)
        ).values('total_order')[:1]

        return qs

    @action(detail=False, methods=['post'], url_path='createOrder')
    def create_order(self, request):
        try:
            with transaction.atomic():
                service = Service.objects.filter(
                    id=request.data['service'],
                ).get()
                if not service.is_open:
                    return Response(data="CLOSED ORDER", status=status.HTTP_403_FORBIDDEN)

                if Order.objects.filter(
                        Q(order_status=OrderStatus.BELUM_DIKERJAKAN) | Q(order_status=OrderStatus.SEDANG_DIKERJAKAN),
                        user__firebase_id=request.data['user'],
                        date=date.today(),
                ).exists():
                    if Order.objects.filter(
                            user__firebase_id=request.data['user'],
                            service__id=request.data['service']
                    ).exists():
                        return Response(data="ALREADY ORDERED", status=status.HTTP_403_FORBIDDEN)
                    return Response(data="EXISTED ORDER", status=status.HTTP_403_FORBIDDEN)
                else:
                    qs = Order.objects.filter(
                        service__id=request.data['service'],
                        date=date.today(),
                    ).values('service__id').annotate(
                        total_order=Coalesce(Count('service__id'), 0)
                    ).values('total_order')[:1]
                    if qs.exists():
                        request.data['index'] = qs[0]['total_order'] + 1
                    else:
                        request.data['index'] = 1
                    request.data['vehicle_type'] = service.vehicle_type
                    serializer = OrderSerializer(data=request.data)
                    if serializer.is_valid():
                        serializer.save()
                        user = User.objects.filter(service__id=request.data['service']).get()
                        push_notification(user.firebase_token)
                        return Response(serializer.data, status=status.HTTP_201_CREATED)
                    else:
                        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='orderPermissionChecking')
    def order_permission_checking(self, request):
        try:
            with transaction.atomic():
                user_id = self.request.query_params.get('user_id', default=None)
                service_id = self.request.query_params.get('service_id', default=None)
                service = Service.objects.filter(
                    id=service_id
                ).get()
                if not service.is_open:
                    return Response(data="CLOSED ORDER", status=status.HTTP_403_FORBIDDEN)

                if Order.objects.filter(
                        Q(order_status=OrderStatus.BELUM_DIKERJAKAN) | Q(order_status=OrderStatus.SEDANG_DIKERJAKAN),
                        user__firebase_id=user_id,
                        date=date.today(),
                ).exists():
                    if Order.objects.filter(
                            user__firebase_id=user_id,
                            service__id=service_id
                    ).exists():
                        return Response(data="ALREADY ORDERED", status=status.HTTP_403_FORBIDDEN)
                    return Response(data="EXISTED ORDER", status=status.HTTP_403_FORBIDDEN)
                else:
                    return Response(data="ALLOWED", status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getUserQueueJson')
    def get_user_queue(self, request):
        user_id = self.request.query_params.get('user_id', default=None)
        try:
            qs = self.queryset.filter(
                Q(order_status=OrderStatus.BELUM_DIKERJAKAN) | Q(order_status=OrderStatus.SEDANG_DIKERJAKAN),
                user__firebase_id=user_id,
                date=date.today(),
            ).annotate(
                service_name=F('service__name'),
                service_address=F('service__address'),
                current_index=Coalesce(F('service__orderqueue__index'), 0),
                last_action=Subquery(
                    OrderProcess.objects.filter(order__id=OuterRef('id')).order_by('-created_at').values('name')[:1])
            ).values('id', 'service', 'user', 'index', 'date', 'order_status', 'service_name', 'service_address',
                     'current_index', 'last_action')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getUndoneOrderJson')
    def get_undone_order_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date=date.today(),
                order_status=OrderStatus.BELUM_DIKERJAKAN,
            ).annotate(
                user_full_name=F('user__full_name'),
                service_name=F('service_package__name'),
            ).values('id', 'service', 'user', 'index', 'date', 'order_status', 'plate_number', 'service_package',
                     'order_status', 'user_full_name', 'service_name')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getCancelledOrderJson')
    def get_cancelled_order_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date=date.today(),
                order_status=OrderStatus.DIBATALKAN,
            ).annotate(
                user_full_name=F('user__full_name'),
                service_name=F('service_package__name'),
            ).values('id', 'service', 'user', 'index', 'date', 'order_status', 'plate_number', 'service_package',
                     'notes',
                     'order_status', 'user_full_name', 'service_name')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getOnProgressOrderJson')
    def get_on_progress_order_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date=date.today(),
                order_status=OrderStatus.SEDANG_DIKERJAKAN,
            ).annotate(
                user_full_name=F('user__full_name'),
                service_name=F('service_package__name'),
                last_action=Subquery(
                    OrderProcess.objects.filter(order__id=OuterRef('id')).order_by('-created_at').values('name')[:1])
            ).values('id', 'service', 'user', 'index', 'date', 'order_status', 'plate_number', 'service_package',
                     'notes',
                     'order_status', 'user_full_name', 'service_name', 'last_action')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getDoneOrderJson')
    def get_done_order_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date=date.today(),
                order_status=OrderStatus.SELESAI,
            ).annotate(
                user_full_name=F('user__full_name'),
                service_name=F('service_package__name'),
            ).values('id', 'service', 'user', 'index', 'date', 'order_status', 'plate_number', 'service_package',
                     'notes', 'order_status', 'user_full_name', 'service_name')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getTodayOrderQueueJson')
    def get_today_order_queue_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date=date.today(),
            ).values('service__id').annotate(
                current_queue_index=Coalesce(Subquery(
                    OrderQueue.objects.filter(service__id=OuterRef('service__id')).values('index')[:1]), 0),
                total_queue=Count('service__id')
            )[:1].values('current_queue_index', 'total_queue')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response({'current_queue_index': 0, 'total_queue': 0}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getThisMonthOrderStatisticJson')
    def get_this_month_order_statistic_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date__range=[date.today().replace(day=1), date.today()]
            ).values('service__id').annotate(
                total_cancelled_order=Subquery(
                    Order.objects.filter(
                        service__id=OuterRef('service__id'),
                        order_status=OrderStatus.DIBATALKAN,
                        date__range=[date.today().replace(day=1), date.today()]
                    ).values('service__id').annotate(
                        total_cancelled_order=Count('service__id')
                    ).values('total_cancelled_order')[:1]
                ),
                total_order=Count('service__id'),
            )[:1].values()
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response({'total_cancelled_order': 0, 'total_order': 0}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getTodayIncomeJson')
    def get_today_income_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date=date.today(),
            ).values('service__id').annotate(
                total_income=Sum(Coalesce(F('orderdetail__quantity'), 1) * Coalesce(F('orderdetail__cost'), 0))
            )[:1].values('total_income')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response({'total_income': 0}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getTodayOrderStatisticJson')
    def get_today_order_statistic_json(self, request):
        def get_today_total_order(order_status=None):
            return Order.objects.filter(
                service__id=OuterRef('service__id'),
                order_status=order_status,
                date__range=[date.today().replace(day=1), date.today()]
            ).values('service__id').annotate(
                total_order=Count('service__id')
            ).values('total_order')[:1]

        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date=date.today()
            ).values('service__id').annotate(
                total_cancelled_order=Coalesce(
                    Subquery(get_today_total_order(order_status=OrderStatus.BELUM_DIKERJAKAN)), 0),
                total_on_progress_order=Coalesce(
                    Subquery(get_today_total_order(order_status=OrderStatus.SEDANG_DIKERJAKAN)), 0),
                total_done_order=Coalesce(Subquery(get_today_total_order(order_status=OrderStatus.SELESAI)), 0),
                total_paid_order=Coalesce(Subquery(get_today_total_order(order_status=OrderStatus.DIBAYAR)), 0),
            )[:1].values('total_cancelled_order', 'total_on_progress_order', 'total_done_order', 'total_paid_order')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response({'total_cancelled_order': 0, 'total_on_progress_order': 0, 'total_done_order': 0,
                                 'total_paid_order': 0}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getThisMonthIncomeJson')
    def get_this_month_income_json(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date__range=[date.today().replace(day=1), date.today()]
            ).values('service__id').annotate(
                total_income=Sum(Coalesce(F('orderdetail__quantity'), 1) * Coalesce(F('orderdetail__cost'), 0))
            )[:1].values('total_income')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response({'total_income': 0}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['patch'], url_path='processingOrder')
    def processing_order(self, request):
        try:
            with transaction.atomic():
                order_id = self.request.query_params.get('order_id', default=None)
                order = self.queryset.filter(
                    id=order_id,
                )
                if order.exists():
                    serializer = OrderSerializer(order.get(), data=request.data, partial=True)
                    if serializer.is_valid():
                        self.perform_update(serializer)

                        user = User.objects.filter(firebase_id=serializer.data['user']).get()
                        push_notification(device_token=user.firebase_token, title="Order telah diproses",
                                          body="Kendaraan kamu masuk dalam tahap pengerjaan")
                        return Response(serializer.data, status=status.HTTP_200_OK)
                    else:
                        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response([], status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['patch'], url_path='cancelOrder')
    def cancel_order(self, request):
        try:
            order_id = self.request.query_params.get('order_id', default=None)
            with transaction.atomic():
                order = self.queryset.filter(
                    id=order_id,
                )
                if order.exists():
                    serializer = OrderSerializer(order.get(), data=request.data, partial=True)
                    if serializer.is_valid():
                        self.perform_update(serializer)
                        user = User.objects.filter(firebase_id=serializer.data['user']).get()
                        push_notification(device_token=user.firebase_token, title="Order dibatalkan",
                                          body=f"Penyedia jasa telah membatalkan permintaan order mu karena alasan {request.data['notes']}")
                        OrderQueue.objects.filter(service__id=serializer.data['service']).update(index=F('index') + 1)
                        self.notify_user_about_queue(serializer)
                        return Response(serializer.data, status=status.HTTP_200_OK)
                    else:
                        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response([], status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['patch'], url_path='finishingOrder')
    def finishing_order(self, request):
        try:
            with transaction.atomic():
                order_id = self.request.query_params.get('order_id', default=None)
                order = self.queryset.filter(
                    id=order_id,
                )
                if order.exists():
                    serializer = OrderSerializer(order.get(), data=request.data, partial=True)
                    if serializer.is_valid():
                        self.perform_update(serializer)

                        user = User.objects.filter(firebase_id=serializer.data['user']).get()
                        push_notification(device_token=user.firebase_token, title="Order selesai",
                                          body="Kendaraan kamu telah selesai dikerjakan")
                        OrderQueue.objects.filter(service__id=serializer.data['service']).update(index=F('index') + 1)
                        self.notify_user_about_queue(serializer)
                        return Response(serializer.data, status=status.HTTP_200_OK)
                    else:
                        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response([], status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['patch'], url_path='paidOrder')
    def paid_order(self, request):
        try:
            with transaction.atomic():
                order_id = self.request.query_params.get('order_id', default=None)
                order = self.queryset.filter(
                    id=order_id,
                )
                if order.exists():
                    serializer = OrderSerializer(order.get(), data=request.data, partial=True)
                    if serializer.is_valid():
                        self.perform_update(serializer)

                        user = User.objects.filter(firebase_id=serializer.data['user']).get()
                        push_notification(device_token=user.firebase_token, title="Pembayaran order dikonfirmasi",
                                          body="Order telah berhasil diselesaikan, terima kasih")
                        order = order.annotate(user_firebase_token=F('service__user__firebase_token'))[:1].values(
                            'user_firebase_token')
                        push_notification(device_token=order[0]['user_firebase_token'])
                        return Response(serializer.data, status=status.HTTP_200_OK)
                    else:
                        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                else:
                    return Response([], status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getServiceProviderOrderHistory')
    def get_service_provider_order_history(self, request):
        service_id = self.request.query_params.get('service_id', default=None)
        from_date = self.request.query_params.get('from_date', default=None)
        to_date = self.request.query_params.get('to_date', default=None)
        try:
            qs = self.queryset.filter(
                service__id=service_id,
                date__range=[from_date, to_date],
            ).annotate(
                user_full_name=F('user__full_name'),
                service_package_name=F('service_package__name'),
                total_cost=Coalesce(Sum(F('orderdetail__quantity') * F('orderdetail__cost')), 0),
            ).order_by('-id').values('id', 'service', 'user', 'user_full_name', 'index', 'date', 'plate_number',
                                     'order_status', 'service_package_name', 'total_cost')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getOrderHistoryJson')
    def get_order_history_json(self, request):
        order_id = self.request.query_params.get('order_id', default=None)
        try:
            qs = self.queryset.filter(
                id=order_id,
            ).annotate(
                user_full_name=F('user__full_name'),
                service_name=F('service__name'),
                service_address=F('service__address'),
                service_package_name=F('service_package__name'),
                service_package_cost=F('service_package__cost'),
                total_cost=Coalesce(Sum(F('orderdetail__quantity') * F('orderdetail__cost')), 0),
            )[:1].values('id', 'vehicle_type', 'user_full_name', 'date', 'plate_number', 'service_name',
                         'service_address', 'service_package_name', 'service_package_cost', 'order_status', 'index',
                         'total_cost')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)

    @action(detail=False, methods=['get'], url_path='getUserOrderHistoryJson')
    def get_user_order_history_json(self, request):
        firebase_id = self.request.query_params.get('firebase_id', default=None)
        try:
            qs = self.queryset.filter(
                user__firebase_id=firebase_id
            ).annotate(
                service_name=F('service__name'),
                service_address=F('service__address'),
                service_package_name=F('service_package__name'),
                review_id=F('review__id'),
                total_cost=Coalesce(Sum(F('orderdetail__quantity') * F('orderdetail__cost')), 0),
            ).order_by('-date', '-id').values('id', 'service', 'review_id', 'index', 'date', 'order_status',
                                              'vehicle_type', 'service_name', 'service_address', 'service_package_name',
                                              'total_cost', 'plate_number')
            if qs.exists():
                return Response(qs, status=status.HTTP_200_OK)
            else:
                return Response([], status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)


class OrderQueueViewSet(viewsets.ModelViewSet):
    queryset = OrderDetail.objects.all()
    serializer_class = OrderDetailSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = '__all__'
    ordering_fields = '__all__'
    search_fields = '__all__'


class OrderProcessViewSet(viewsets.ModelViewSet):
    queryset = OrderProcess.objects.all()
    serializer_class = OrderProcessSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = '__all__'
    ordering_fields = '__all__'
    search_fields = '__all__'

    @action(detail=False, methods=['post'], url_path='createOrderProcess')
    def create_order(self, request):
        try:
            with transaction.atomic():
                serializer = OrderProcessSerializer(data=request.data)
                if serializer.is_valid():
                    serializer.save()
                    order = Order.objects.filter(id=serializer.data['order']).annotate(
                        user_firebase_token=F('user__firebase_token')).get()
                    push_notification(order.user_firebase_token, title="Pemberitahuan",
                                      body=f"Kendaraan telah sampai pada proses {serializer.data['name']}")
                    return Response(serializer.data, status=status.HTTP_201_CREATED)
                else:
                    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)


class OrderDetailViewSet(viewsets.ModelViewSet):
    queryset = OrderDetail.objects.all()
    serializer_class = OrderDetailSerializer
    filter_backends = [DjangoFilterBackend, filters.OrderingFilter, filters.SearchFilter, ]
    filterset_fields = ['order__id']
    ordering_fields = '__all__'
    search_fields = '__all__'
