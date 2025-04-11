# Gunakan image resmi PHP dengan extensions untuk Laravel
FROM php:8.2-cli

# Install ekstensi PHP yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    libzip-dev unzip curl git \
    && docker-php-ext-install zip pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set workdir
WORKDIR /app

# Copy semua file ke container
COPY . .

# Install dependencies Laravel
RUN composer install --no-interaction

# Jalankan Laravel dengan artisan serve
CMD php artisan serve --host=0.0.0.0 --port=${PORT}
