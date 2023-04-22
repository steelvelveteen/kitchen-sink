#!/bin/bash

read -p "Enter the name of the application: " appname

ng new $appname --routing

cd $appname

ng generate module core --routing
ng generate component core/login --module core/core.module.ts
ng generate component core/signup --module core/core.module.ts
ng generate guard core/auth --implements CanActivate --module core/core.module.ts
ng generate guard core/role --implements CanActivate --module core/core.module.ts
ng generate service core/auth --module core/core.module.ts

ng generate module shared --routing
ng generate service shared/shared --module shared/shared.module.ts
ng generate component shared/header --module shared/shared.module.ts
ng generate directive shared/highlight --module shared/shared.module.ts
ng generate pipe shared/currency --module shared/shared.module.ts

ng generate module feature --routing
ng generate module feature/orders --routing --module feature/feature.module.ts
ng generate component feature/orders/list --module feature/orders/orders.module.ts
ng generate component feature/orders/details --module feature/orders/orders.module.ts
ng generate service feature/orders/order --module feature/orders/orders.module.ts
ng generate pipe feature/orders/filter --module feature/orders/orders.module.ts
