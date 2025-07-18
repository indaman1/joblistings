# Use the official PHP image
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    npm \
    nodejs \
    libzip-dev \
    libpq-dev \
    sqlite3 \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite mbstring zip exif pcntl bcmath

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy application files
COPY . .

# Install PHP dependencies
RUN composer install --optimize-autoloader --no-dev

# Install JS dependencies and compile assets
RUN npm install && npm run build

# Clear and cache Laravel config
RUN php artisan config:clear \
 && php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache

# Create SQLite database file (optional)
RUN mkdir -p database \
 && touch /var/www/database/database.sqlite

# Set file permissions
RUN chown -R www-data:www-data /var/www \
 && chmod -R 775 storage bootstrap/cache database

# Expose port
EXPOSE 8000

# Start Laravel development server (not for production scale)
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
