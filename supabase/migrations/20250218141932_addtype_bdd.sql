create type "public"."goal_type" as enum ('Perdre du poids', 'Prendre de la masse', 'Gagner du muscle et perdre de la graisse', 'Manger plus sainement', 'Préparer une compétition');

alter table "public"."users" alter column "goal" set data type goal_type using "goal"::goal_type;


