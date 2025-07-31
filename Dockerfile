# Dockerfile

# ---- Stage 1: Build ----
# Tahap ini menginstal dependencies dan menyiapkan aplikasi.
FROM node:20-alpine AS builder

WORKDIR /app

# Salin package.json dan package-lock.json terlebih dahulu untuk caching
COPY package*.json ./

# Install hanya dependencies untuk produksi
RUN npm ci --only=production

# Salin sisa kode aplikasi
COPY . .

# ---- Stage 2: Production ----
# Tahap ini membuat image akhir yang akan dijalankan.
FROM node:20-alpine

WORKDIR /app

# Salin node_modules dan kode aplikasi dari tahap 'builder'
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app .

# Expose port yang digunakan oleh aplikasi Anda (ubah jika perlu)
EXPOSE 3000

# Perintah untuk menjalankan aplikasi
CMD [ "node", "server.js" ]