from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('', include('{PROJECT}.core.urls', namespace='core')),
    path('crm/', include('{PROJECT}.crm.urls', namespace='crm')),
    path('admin/', admin.site.urls),
]
