# Gunakan image PHP dengan ekstensi yang dibutuhkan
FROM php:8.2-cli

# Install dependency sistem & ekstensi PHP
RUN apt-get update && apt-get install -y \
    unzip git curl libzip-dev \
    && docker-php-ext-install pdo pdo_mysql zip

# Install Node.js & NPM (kalau kamu mau build Vite di container)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set direktori kerja
WORKDIR /app

# Copy semua file ke dalam container (kecuali yang di .dockerignore)
COPY . .

# Install PHP dependency
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Build asset Vite (jika kamu ingin build di container)
RUN npm install && npm run build

# Jalankan Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
