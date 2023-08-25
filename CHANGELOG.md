# CHANGELOG

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [ Unrelease ]

## [0.1.0] - 2023-08-25

-   Added balances - Users can add their balances
-   Currency syncronization - Currencies are synced from [messari.io](https://data.messari.io/api/v2/assets) API
-   Currency profit can be updated by importing a CSV file with the required information
-   Profit calculation
    -   Only `active` currencies will be listed in the profit and balances section.
-   Added currencies table (from the above API) to be exported to CSV and JSON formats
    -   A background worker is syncing the currency information every minute

## [0.0.1] - 2023-08-24

### Added

-   User account - Users can sign up and create their accounts
-   Methods to track signed in information
-   Users session - Users can sign in and sign out
