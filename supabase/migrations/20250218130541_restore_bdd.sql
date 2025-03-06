create type "public"."contrainte_type" as enum ('Végétarien', 'Végétalien', 'Sans gluten', 'Sans sucre', 'Halal');

alter table "public"."users" add column "contrainte" contrainte_type;


