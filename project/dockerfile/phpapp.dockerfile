FROM php:8.1.18-fpm
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ../junior-devops-spetsialist/src/ /var/www/laravel/
COPY ../.env /var/www/laravel/.env
RUN apt update && apt install -y \
    nodejs \
    npm \
    git \
    unzip 
WORKDIR /var/www/laravel
RUN docker-php-ext-install pdo pdo_mysql 
RUN composer install  
RUN npm install 
RUN php artisan 
RUN chown -R www-data:www-data /var/www/laravel/
RUN php artisan key:generate
EXPOSE 9000
EXPOSE 80
CMD ["php-fpm"]
# docker-php-ext-install pdo_mysql