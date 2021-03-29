# django_on_kubernetes

## clone
```shell
git clone --recursive https://github.com/shuji-oh/django_on_kubernetes  
```  

## GCPのpython-docs-sampleのコードの変更
django v2.2 LTSで動かすために，以下の項目を変更する．

```shell
$ cd django_on_kubernetes/python-docs-samples  
$ git apply ../diff_python-docs-samples.patch  
```

```diff
diff --git a/kubernetes_engine/django_tutorial/mysite/settings.py b/kubernetes_engine/django_tutorial/mysite/settings.py
index bdcb3991..c3742f93 100644
--- a/kubernetes_engine/django_tutorial/mysite/settings.py
+++ b/kubernetes_engine/django_tutorial/mysite/settings.py
@@ -80,13 +80,12 @@ WSGI_APPLICATION = 'mysite.wsgi.application'
 DATABASES = {
     'default': {
         # If you are using Cloud SQL for MySQL rather than PostgreSQL, set
-        # 'ENGINE': 'django.db.backends.mysql' instead of the following.
-        'ENGINE': 'django.db.backends.postgresql',
+        'ENGINE': 'django.db.backends.mysql',
         'NAME': 'polls',
         'USER': os.getenv('DATABASE_USER'),
         'PASSWORD': os.getenv('DATABASE_PASSWORD'),
-        'HOST': '127.0.0.1',
-        'PORT': '5432',
+        'HOST': 'mysql-clusterip',
+        'PORT': '13306',
     }
 }
 # [END dbconfig]
diff --git a/kubernetes_engine/django_tutorial/mysite/urls.py b/kubernetes_engine/django_tutorial/mysite/urls.py
index bbb417c4..24199059 100644
--- a/kubernetes_engine/django_tutorial/mysite/urls.py
+++ b/kubernetes_engine/django_tutorial/mysite/urls.py
@@ -15,7 +15,8 @@
 from django.conf import settings
 from django.contrib import admin
 from django.contrib.staticfiles.urls import staticfiles_urlpatterns
-from django.urls import include, path
+from django.conf.urls import include
+from django.urls import path
 urlpatterns = [
diff --git a/kubernetes_engine/django_tutorial/requirements.txt b/kubernetes_engine/django_tutorial/requirements.txt
index f2682968..9a277637 100644
--- a/kubernetes_engine/django_tutorial/requirements.txt
+++ b/kubernetes_engine/django_tutorial/requirements.txt
@@ -1,9 +1,7 @@
-Django==3.0.2; python_version > '3.5'
-Django==2.2.9; python_version == '3.5'
-Django==1.11.28;python_version < '3.0'
+Django==2.2.9
 # Uncomment the mysqlclient requirement if you are using MySQL rather than
 # PostgreSQL. You must also have a MySQL client installed in that case.
-#mysqlclient==1.4.1
+mysqlclient==1.4.1
 wheel==0.36.2
 gunicorn==20.0.4; python_version > '3.0'
 gunicorn==19.10.0; python_version < '3.0'
```
