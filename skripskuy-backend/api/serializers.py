from rest_framework import serializers
from bookqueue.models import *


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class ServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Service
        fields = '__all__'


class ServicePackageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ServicePackage
        fields = '__all__'


class ReviewSerializer(serializers.ModelSerializer):
    class Meta:
        model = Review
        fields = '__all__'


class OperationalServiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = OperationalService
        fields = '__all__'


class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'


class OrderQueueSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderQueue
        fields = '__all__'


class OrderProcessSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderProcess
        fields = '__all__'


class OrderDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = OrderDetail
        fields = '__all__'
