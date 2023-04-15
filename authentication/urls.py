from django.urls import path
from authentication import views


urlpatterns = [
    path('login', views.Login.as_view(), name='login_page'),
]
