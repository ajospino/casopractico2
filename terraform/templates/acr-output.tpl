acr_login_url: ${acr_login_url}
acr_username: ${acr_user}
acr_password: ${acr_password}

#Not part of the ACR output, but putting it here as to automate the functionality

root_db_password: laravel_admin
app_name: webserver-ruby
pvc_size: 1Gi
storage_class: managed-csi
app_image: ${acr_login_url}/ruby-webserver:casopractico2