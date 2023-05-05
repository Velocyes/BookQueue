from django.contrib import admin
from .models import *

admin.site.register(User)
admin.site.register(Service)
admin.site.register(ServicePackage)
admin.site.register(Review)
admin.site.register(OperationalService)
admin.site.register(Order)
admin.site.register(OrderQueue)
admin.site.register(OrderProcess)
admin.site.register(OrderDetail)
