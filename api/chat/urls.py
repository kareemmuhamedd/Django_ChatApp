from django.urls import path
from .views import SignInView

urlpatterns = [
    path('singin/',SignInView.as_view())
]