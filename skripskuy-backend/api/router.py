from rest_framework import routers
from . import views

router = routers.DefaultRouter()
router.register('user', views.UserViewSet)
router.register('service', views.ServiceViewSet)
router.register('service-package', views.ServicePackageViewSet)
router.register('review', views.ReviewViewSet)
router.register('operational-service', views.OperationalServiceViewSet)
router.register('order', views.OrderViewSet)
router.register('order-queue', views.OrderQueueViewSet)
router.register('order-process', views.OrderProcessViewSet)
router.register('order-detail', views.OrderDetailViewSet)
