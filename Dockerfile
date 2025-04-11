# Gunakan image resmi PHP
FROM php:8.2-cli

# Install ekstensi PHP yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    unzip curl git zip libzip-dev \
    libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install \
    pdo pdo_mysql mbstring zip exif pcntl bcmath

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /app

# Salin semua file ke dalam container
COPY . .

# Install dependencies Laravel
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Jalankan Laravel saat container start
CMD php artisan serve --host=0.0.0.0 --port=${PORT}
