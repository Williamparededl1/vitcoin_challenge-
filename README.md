# Reto Técnico VitCoin 🔱

Esta es la implementación del reto técnico para Vita-Wallet, una API en Rails para un sistema transaccional centralizado basado en criptografía.

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
4.  Crea, migra y siembra la base de datos. El último comando (`db:seed`) creará la billetera master con un saldo inicial.
    ```bashs
    rails db:create db:migrate db:seed
    ```

## Billetera Master de Pruebas

El sistema se inicializa con una billetera master con fondos para poder realizar pruebas y fondear otras billeteras. Las credenciales son:

* **Dirección (Address):** `abdc81eefaa84e464457fefe3785fa7bce677af49cfd97befa172eec180dd62b`
* **Llave Privada (Private Key en Base64):** `QfevC12+l5MyZq8AdQfNZZW3TqBHDzMZRQjpRiRno8Y=`

Puedes usar esta llave privada en los scripts proporcionados para firmar transacciones desde la billetera master y enviar fondos a cualquier otra dirección.

## Cómo Correr las Pruebas

Para ejecutar la suite de pruebas completa (modelos y requests), usa RSpec:
```bash
bundle exec rspec
Cómo Iniciar el Servidor
Bash

rails server
La API estará disponible en http://localhost:3000.

Endpoints de la API

GET /api/addresses/:address: Devuelve los detalles de una billetera.

POST /api/transactions: Procesa y crea una nueva transacción a partir de una carga útil firmada.

GET /api/transactions/:uuid: Devuelve los detalles de una transacción específica.