create type "public"."restrictions_type" as enum ('Végétarien', 'Végétalien', 'Sans gluten', 'Sans sucre', 'Halal', 'Aucune');

create type "public"."goal_type" as enum ('Perdre du poids', 'Prendre de la masse', 'Gagner du muscle et perdre de la graisse', 'Manger plus sainement', 'Préparer une compétition', 'Aucune');

alter type "public"."goal_type" rename to "goal_type__old_version_to_be_dropped";

alter type "public"."sport_type" rename to "sport_type__old_version_to_be_dropped";

create type "public"."sport_type" as enum ('course à pied', 'natation', 'cyclisme', 'tennis', 'football', 'basketball', 'musculation', 'yoga', 'marathon', 'triathlon', 'escalade', 'danse', 'boxe', 'rugby', 'ju-jitsu', 'mma', 'grappling', 'handball', 'autre', 'aucun');

DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                  WHERE table_schema = 'public' 
                  AND table_name = 'users' 
                  AND column_name = 'restrictions') THEN
        ALTER TABLE "public"."users" ADD COLUMN "restrictions" text;
    END IF;
END $$;

alter table "public"."users" alter column goal type "public"."goal_type" using goal::text::"public"."goal_type";

alter table "public"."users" alter column sport type "public"."sport_type" using sport::text::"public"."sport_type";

drop type "public"."goal_type__old_version_to_be_dropped";

drop type "public"."sport_type__old_version_to_be_dropped";

alter table "public"."users" alter column "contrainte" set data type restrictions_type using "contrainte"::text::restrictions_type;

drop type "public"."contrainte_type";


