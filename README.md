# Reto Técnico VitCoin 🔱

Esta es la implementación del reto técnico para Vit-Wallet, una API en Rails para un sistema transaccional centralizado basado en criptografía.

## Versiones Requeridas

* Ruby `3.2.2`
* PostgreSQL `16.x`

## Instalación y Configuración

1.  Clona el repositorio.
2.  Asegúrate de tener Ruby 3.2.2 y PostgreSQL instalado y corriendo.
3.  Instala las dependencias del proyecto:
    ```bash
    bundle install
    ```
4.  Crea y configura la base de datos:
    ```bash
    rails db:create
    rails db:migrate
    ```

## Cómo Correr las Pruebas

Para ejecutar la suite de pruebas completa, usa RSpec:
```bash
bundle exec rspec
```

## Cómo Iniciar el Servidor

```bash
rails server
```
La API estará disponible en `http://localhost:3000`.

## Endpoints de la API

* `GET /api/addresses/:address`: Devuelve los detalles de una billetera.
* `POST /api/transactions`: Procesa y crea una nueva transacción a partir de una carga útil firmada.
* `GET /api/transactions/:uuid`: Devuelve los detalles de una transacción específica.