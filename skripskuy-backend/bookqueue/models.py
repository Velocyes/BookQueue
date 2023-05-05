from django.db import models
from django.db.models import IntegerChoices, CharField, PositiveIntegerField, EmailField, ForeignKey, SET_NULL, \
    DateTimeField, BooleanField, TimeField, DateField, OneToOneField, ImageField


class UserRole(IntegerChoices):
    ADMIN = 0
    USER = 1
    SERVICE_PROVIDER = 2


class VehicleType(IntegerChoices):
    SEMUA = 0
    MOTOR = 1
    MOBIL = 2


class Days(IntegerChoices):
    SENIN = 0
    SELASA = 1
    RABU = 2
    KAMIS = 3
    JUMAT = 4
    SABTU = 5
    MINGGU = 6


class OrderStatus(IntegerChoices):
    BELUM_DIKERJAKAN = 0
    SEDANG_DIKERJAKAN = 1
    SELESAI = 2
    DIBATALKAN = 3
    DIBAYAR = 4


class User(models.Model):
    firebase_id = CharField(primary_key=True, unique=True, null=False, editable=True, max_length=255)
    firebase_token = CharField(null=True, blank=True, editable=True, max_length=255)
    user_role = PositiveIntegerField(choices=UserRole.choices, null=True, blank=True, editable=True,
                                     default=UserRole.USER)
    url_photo = CharField(null=True, blank=True, editable=True, max_length=500, default="")
    profile_picture = ImageField(upload_to='images/', null=True, blank=True)
    full_name = CharField(null=True, blank=True, editable=True, max_length=50, default="")
    phone_number = CharField(null=True, blank=True, editable=True, max_length=20, default="")
    email = EmailField(null=True, blank=True, editable=True, max_length=100, default="")
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)


class Service(models.Model):
    user = ForeignKey(User, on_delete=SET_NULL, null=True)
    name = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    address = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    profile_picture = ImageField(upload_to='images/', null=True, blank=True)
    vehicle_type = PositiveIntegerField(choices=VehicleType.choices, null=True, blank=True, editable=True,
                                        default=VehicleType.SEMUA)
    description = CharField(null=True, blank=True, editable=True, max_length=1000, default="")
    is_open = BooleanField(null=True, blank=True, editable=True, default=False)
    open_hour = TimeField(null=True, blank=True, editable=True)
    close_hour = TimeField(null=True, blank=True, editable=True)
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)


class ServicePackage(models.Model):
    service = ForeignKey(Service, on_delete=SET_NULL, null=True, blank=False)
    name = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    type = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    description = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    cost = PositiveIntegerField(null=True, blank=True, editable=True, default=0)
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)


class Order(models.Model):
    service = ForeignKey(Service, on_delete=SET_NULL, null=True)
    user = ForeignKey(User, on_delete=SET_NULL, null=True)
    vehicle_type = PositiveIntegerField(choices=VehicleType.choices, null=True, blank=True, editable=True,
                                        default=VehicleType.SEMUA)
    index = PositiveIntegerField(null=True, blank=True, editable=True, default=1)
    date = DateField(auto_now_add=True, null=True, blank=True, editable=True)
    plate_number = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    service_package = ForeignKey(ServicePackage, on_delete=SET_NULL, null=True)
    order_status = PositiveIntegerField(choices=OrderStatus.choices, null=True, blank=True, editable=True,
                                        default=OrderStatus.BELUM_DIKERJAKAN)
    notes = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)


class Review(models.Model):
    order = ForeignKey(Order, on_delete=SET_NULL, null=True)
    service = ForeignKey(Service, on_delete=SET_NULL, null=True)
    user = ForeignKey(User, on_delete=SET_NULL, null=True)
    date = DateField(auto_now_add=True, blank=True, editable=True)
    rating = PositiveIntegerField(null=True, blank=True, editable=True, default=0)
    description = CharField(null=True, blank=True, editable=True, max_length=1000, default="")
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)


class OperationalService(models.Model):
    service = ForeignKey(Service, on_delete=SET_NULL, null=True)
    is_open = BooleanField(null=True, blank=True, editable=True, default=False)
    day = PositiveIntegerField(choices=Days.choices, null=True, blank=True, editable=True, default=Days.SENIN)
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)

    class Meta:
        unique_together = ('service', 'day',)


class OrderQueue(models.Model):
    service = OneToOneField(Service, unique=True, on_delete=SET_NULL, null=True)
    date = DateField(auto_now_add=True, null=True, blank=True, editable=True)
    index = PositiveIntegerField(null=True, blank=True, editable=True, default=1)
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)


class OrderProcess(models.Model):
    order = ForeignKey(Order, on_delete=SET_NULL, null=True)
    name = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)


class OrderDetail(models.Model):
    order = ForeignKey(Order, on_delete=SET_NULL, null=True)
    header = CharField(null=True, blank=True, editable=True, max_length=255, default="")
    quantity = PositiveIntegerField(null=True, blank=True, editable=True, default=0)
    cost = PositiveIntegerField(null=True, blank=True, editable=True, default=0)
    created_at = DateTimeField(auto_now_add=True, blank=True, editable=True)
    updated_at = DateTimeField(auto_now=True, blank=True, editable=True)
