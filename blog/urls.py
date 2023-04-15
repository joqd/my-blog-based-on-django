from django.urls import path
from blog import views

urlpatterns = [
    path('', views.Index.as_view(), name='index_page'),
]
