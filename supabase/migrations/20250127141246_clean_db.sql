create type "public"."friendship_status" as enum ('pending', 'accepted', 'declined', 'blocked');

create type "public"."progress_notes" as enum ('Semaine parfaite !', 'Bonne semaine !', 'Moyenne semaine', 'Mauvaise semaine', 'J''ai eu beaucoup de mal');

create type "public"."sport_type" as enum ('course à pied', 'natation', 'cyclisme', 'tennis', 'football', 'basketball', 'musculation', 'yoga', 'marathon', 'triathlon', 'escalade', 'danse', 'boxe', 'rugby', 'ju-jitsu', 'mma', 'grappling', 'handball', 'autre');

create table "public"."collaborations" (
    "id" uuid not null default uuid_generate_v4(),
    "name" text not null,
    "type" text not null,
    "location" text,
    "commission_rate" double precision not null,
    "created_at" timestamp without time zone default CURRENT_TIMESTAMP
);


create table "public"."friendships" (
    "id" uuid not null default uuid_generate_v4(),
    "user_id" uuid,
    "friend_id" uuid,
    "status" friendship_status default 'pending'::friendship_status,
    "created_at" timestamp without time zone default CURRENT_TIMESTAMP
);


create table "public"."meal_plans" (
    "id" uuid not null default uuid_generate_v4(),
    "plan_id" uuid,
    "meal_id" uuid,
    "prepared_meal_id" uuid,
    "meal_time" timestamp without time zone not null
);


create table "public"."meals" (
    "id" uuid not null default uuid_generate_v4(),
    "name" text not null,
    "description" text,
    "calories" double precision not null,
    "proteins" double precision,
    "carbs" double precision,
    "fats" double precision,
    "created_at" timestamp without time zone default CURRENT_TIMESTAMP
);


create table "public"."nutrition_plans" (
    "id" uuid not null default uuid_generate_v4(),
    "user_id" uuid,
    "name" text not null,
    "calories_per_day" double precision not null,
    "start_date" date not null,
    "end_date" date not null,
    "active" boolean default false,
    "created_at" timestamp without time zone default CURRENT_TIMESTAMP
);


create table "public"."prepared_meals" (
    "id" uuid not null default uuid_generate_v4(),
    "name" text not null,
    "description" text,
    "calories" double precision not null,
    "proteins" double precision,
    "carbs" double precision,
    "fats" double precision,
    "price" double precision not null,
    "collaboration_id" uuid,
    "created_at" timestamp without time zone default CURRENT_TIMESTAMP
);


create table "public"."progress" (
    "id" uuid not null default uuid_generate_v4(),
    "user_id" uuid,
    "weight" double precision not null,
    "date" date default CURRENT_DATE,
    "notes" progress_notes
);


create table "public"."users" (
    "id" uuid not null default uuid_generate_v4(),
    "email" text not null,
    "password_hash" text not null,
    "name" text not null,
    "age" integer,
    "gender" text,
    "height" double precision,
    "weight" double precision,
    "basal_metabolic_rate" double precision,
    "goal" text,
    "sport" sport_type not null,
    "competition" boolean default false,
    "weekly_sports_count" integer default 0,
    "deadline" date,
    "api_connected" boolean default false,
    "created_at" timestamp without time zone default CURRENT_TIMESTAMP
);


CREATE UNIQUE INDEX collaborations_pkey ON public.collaborations USING btree (id);

CREATE UNIQUE INDEX friendships_pkey ON public.friendships USING btree (id);

CREATE UNIQUE INDEX meal_plans_pkey ON public.meal_plans USING btree (id);

CREATE UNIQUE INDEX meals_pkey ON public.meals USING btree (id);

CREATE UNIQUE INDEX nutrition_plans_pkey ON public.nutrition_plans USING btree (id);

CREATE UNIQUE INDEX prepared_meals_pkey ON public.prepared_meals USING btree (id);

CREATE UNIQUE INDEX progress_pkey ON public.progress USING btree (id);

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

alter table "public"."collaborations" add constraint "collaborations_pkey" PRIMARY KEY using index "collaborations_pkey";

alter table "public"."friendships" add constraint "friendships_pkey" PRIMARY KEY using index "friendships_pkey";

alter table "public"."meal_plans" add constraint "meal_plans_pkey" PRIMARY KEY using index "meal_plans_pkey";

alter table "public"."meals" add constraint "meals_pkey" PRIMARY KEY using index "meals_pkey";

alter table "public"."nutrition_plans" add constraint "nutrition_plans_pkey" PRIMARY KEY using index "nutrition_plans_pkey";

alter table "public"."prepared_meals" add constraint "prepared_meals_pkey" PRIMARY KEY using index "prepared_meals_pkey";

alter table "public"."progress" add constraint "progress_pkey" PRIMARY KEY using index "progress_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."friendships" add constraint "friendships_friend_id_fkey" FOREIGN KEY (friend_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."friendships" validate constraint "friendships_friend_id_fkey";

alter table "public"."friendships" add constraint "friendships_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."friendships" validate constraint "friendships_user_id_fkey";

alter table "public"."meal_plans" add constraint "meal_plans_meal_id_fkey" FOREIGN KEY (meal_id) REFERENCES meals(id) ON DELETE SET NULL not valid;

alter table "public"."meal_plans" validate constraint "meal_plans_meal_id_fkey";

alter table "public"."meal_plans" add constraint "meal_plans_plan_id_fkey" FOREIGN KEY (plan_id) REFERENCES nutrition_plans(id) ON DELETE CASCADE not valid;

alter table "public"."meal_plans" validate constraint "meal_plans_plan_id_fkey";

alter table "public"."meal_plans" add constraint "meal_plans_prepared_meal_id_fkey" FOREIGN KEY (prepared_meal_id) REFERENCES prepared_meals(id) ON DELETE SET NULL not valid;

alter table "public"."meal_plans" validate constraint "meal_plans_prepared_meal_id_fkey";

alter table "public"."nutrition_plans" add constraint "nutrition_plans_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."nutrition_plans" validate constraint "nutrition_plans_user_id_fkey";

alter table "public"."prepared_meals" add constraint "prepared_meals_collaboration_id_fkey" FOREIGN KEY (collaboration_id) REFERENCES collaborations(id) ON DELETE CASCADE not valid;

alter table "public"."prepared_meals" validate constraint "prepared_meals_collaboration_id_fkey";

alter table "public"."progress" add constraint "progress_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."progress" validate constraint "progress_user_id_fkey";

alter table "public"."users" add constraint "users_email_key" UNIQUE using index "users_email_key";

grant delete on table "public"."collaborations" to "anon";

grant insert on table "public"."collaborations" to "anon";

grant references on table "public"."collaborations" to "anon";

grant select on table "public"."collaborations" to "anon";

grant trigger on table "public"."collaborations" to "anon";

grant truncate on table "public"."collaborations" to "anon";

grant update on table "public"."collaborations" to "anon";

grant delete on table "public"."collaborations" to "authenticated";

grant insert on table "public"."collaborations" to "authenticated";

grant references on table "public"."collaborations" to "authenticated";

grant select on table "public"."collaborations" to "authenticated";

grant trigger on table "public"."collaborations" to "authenticated";

grant truncate on table "public"."collaborations" to "authenticated";

grant update on table "public"."collaborations" to "authenticated";

grant delete on table "public"."collaborations" to "service_role";

grant insert on table "public"."collaborations" to "service_role";

grant references on table "public"."collaborations" to "service_role";

grant select on table "public"."collaborations" to "service_role";

grant trigger on table "public"."collaborations" to "service_role";

grant truncate on table "public"."collaborations" to "service_role";

grant update on table "public"."collaborations" to "service_role";

grant delete on table "public"."friendships" to "anon";

grant insert on table "public"."friendships" to "anon";

grant references on table "public"."friendships" to "anon";

grant select on table "public"."friendships" to "anon";

grant trigger on table "public"."friendships" to "anon";

grant truncate on table "public"."friendships" to "anon";

grant update on table "public"."friendships" to "anon";

grant delete on table "public"."friendships" to "authenticated";

grant insert on table "public"."friendships" to "authenticated";

grant references on table "public"."friendships" to "authenticated";

grant select on table "public"."friendships" to "authenticated";

grant trigger on table "public"."friendships" to "authenticated";

grant truncate on table "public"."friendships" to "authenticated";

grant update on table "public"."friendships" to "authenticated";

grant delete on table "public"."friendships" to "service_role";

grant insert on table "public"."friendships" to "service_role";

grant references on table "public"."friendships" to "service_role";

grant select on table "public"."friendships" to "service_role";

grant trigger on table "public"."friendships" to "service_role";

grant truncate on table "public"."friendships" to "service_role";

grant update on table "public"."friendships" to "service_role";

grant delete on table "public"."meal_plans" to "anon";

grant insert on table "public"."meal_plans" to "anon";

grant references on table "public"."meal_plans" to "anon";

grant select on table "public"."meal_plans" to "anon";

grant trigger on table "public"."meal_plans" to "anon";

grant truncate on table "public"."meal_plans" to "anon";

grant update on table "public"."meal_plans" to "anon";

grant delete on table "public"."meal_plans" to "authenticated";

grant insert on table "public"."meal_plans" to "authenticated";

grant references on table "public"."meal_plans" to "authenticated";

grant select on table "public"."meal_plans" to "authenticated";

grant trigger on table "public"."meal_plans" to "authenticated";

grant truncate on table "public"."meal_plans" to "authenticated";

grant update on table "public"."meal_plans" to "authenticated";

grant delete on table "public"."meal_plans" to "service_role";

grant insert on table "public"."meal_plans" to "service_role";

grant references on table "public"."meal_plans" to "service_role";

grant select on table "public"."meal_plans" to "service_role";

grant trigger on table "public"."meal_plans" to "service_role";

grant truncate on table "public"."meal_plans" to "service_role";

grant update on table "public"."meal_plans" to "service_role";

grant delete on table "public"."meals" to "anon";

grant insert on table "public"."meals" to "anon";

grant references on table "public"."meals" to "anon";

grant select on table "public"."meals" to "anon";

grant trigger on table "public"."meals" to "anon";

grant truncate on table "public"."meals" to "anon";

grant update on table "public"."meals" to "anon";

grant delete on table "public"."meals" to "authenticated";

grant insert on table "public"."meals" to "authenticated";

grant references on table "public"."meals" to "authenticated";

grant select on table "public"."meals" to "authenticated";

grant trigger on table "public"."meals" to "authenticated";

grant truncate on table "public"."meals" to "authenticated";

grant update on table "public"."meals" to "authenticated";

grant delete on table "public"."meals" to "service_role";

grant insert on table "public"."meals" to "service_role";

grant references on table "public"."meals" to "service_role";

grant select on table "public"."meals" to "service_role";

grant trigger on table "public"."meals" to "service_role";

grant truncate on table "public"."meals" to "service_role";

grant update on table "public"."meals" to "service_role";

grant delete on table "public"."nutrition_plans" to "anon";

grant insert on table "public"."nutrition_plans" to "anon";

grant references on table "public"."nutrition_plans" to "anon";

grant select on table "public"."nutrition_plans" to "anon";

grant trigger on table "public"."nutrition_plans" to "anon";

grant truncate on table "public"."nutrition_plans" to "anon";

grant update on table "public"."nutrition_plans" to "anon";

grant delete on table "public"."nutrition_plans" to "authenticated";

grant insert on table "public"."nutrition_plans" to "authenticated";

grant references on table "public"."nutrition_plans" to "authenticated";

grant select on table "public"."nutrition_plans" to "authenticated";

grant trigger on table "public"."nutrition_plans" to "authenticated";

grant truncate on table "public"."nutrition_plans" to "authenticated";

grant update on table "public"."nutrition_plans" to "authenticated";

grant delete on table "public"."nutrition_plans" to "service_role";

grant insert on table "public"."nutrition_plans" to "service_role";

grant references on table "public"."nutrition_plans" to "service_role";

grant select on table "public"."nutrition_plans" to "service_role";

grant trigger on table "public"."nutrition_plans" to "service_role";

grant truncate on table "public"."nutrition_plans" to "service_role";

grant update on table "public"."nutrition_plans" to "service_role";

grant delete on table "public"."prepared_meals" to "anon";

grant insert on table "public"."prepared_meals" to "anon";

grant references on table "public"."prepared_meals" to "anon";

grant select on table "public"."prepared_meals" to "anon";

grant trigger on table "public"."prepared_meals" to "anon";

grant truncate on table "public"."prepared_meals" to "anon";

grant update on table "public"."prepared_meals" to "anon";

grant delete on table "public"."prepared_meals" to "authenticated";

grant insert on table "public"."prepared_meals" to "authenticated";

grant references on table "public"."prepared_meals" to "authenticated";

grant select on table "public"."prepared_meals" to "authenticated";

grant trigger on table "public"."prepared_meals" to "authenticated";

grant truncate on table "public"."prepared_meals" to "authenticated";

grant update on table "public"."prepared_meals" to "authenticated";

grant delete on table "public"."prepared_meals" to "service_role";

grant insert on table "public"."prepared_meals" to "service_role";

grant references on table "public"."prepared_meals" to "service_role";

grant select on table "public"."prepared_meals" to "service_role";

grant trigger on table "public"."prepared_meals" to "service_role";

grant truncate on table "public"."prepared_meals" to "service_role";

grant update on table "public"."prepared_meals" to "service_role";

grant delete on table "public"."progress" to "anon";

grant insert on table "public"."progress" to "anon";

grant references on table "public"."progress" to "anon";

grant select on table "public"."progress" to "anon";

grant trigger on table "public"."progress" to "anon";

grant truncate on table "public"."progress" to "anon";

grant update on table "public"."progress" to "anon";

grant delete on table "public"."progress" to "authenticated";

grant insert on table "public"."progress" to "authenticated";

grant references on table "public"."progress" to "authenticated";

grant select on table "public"."progress" to "authenticated";

grant trigger on table "public"."progress" to "authenticated";

grant truncate on table "public"."progress" to "authenticated";

grant update on table "public"."progress" to "authenticated";

grant delete on table "public"."progress" to "service_role";

grant insert on table "public"."progress" to "service_role";

grant references on table "public"."progress" to "service_role";

grant select on table "public"."progress" to "service_role";

grant trigger on table "public"."progress" to "service_role";

grant truncate on table "public"."progress" to "service_role";

grant update on table "public"."progress" to "service_role";

grant delete on table "public"."users" to "anon";

grant insert on table "public"."users" to "anon";

grant references on table "public"."users" to "anon";

grant select on table "public"."users" to "anon";

grant trigger on table "public"."users" to "anon";

grant truncate on table "public"."users" to "anon";

grant update on table "public"."users" to "anon";

grant delete on table "public"."users" to "authenticated";

grant insert on table "public"."users" to "authenticated";

grant references on table "public"."users" to "authenticated";

grant select on table "public"."users" to "authenticated";

grant trigger on table "public"."users" to "authenticated";

grant truncate on table "public"."users" to "authenticated";

grant update on table "public"."users" to "authenticated";

grant delete on table "public"."users" to "service_role";

grant insert on table "public"."users" to "service_role";

grant references on table "public"."users" to "service_role";

grant select on table "public"."users" to "service_role";

grant trigger on table "public"."users" to "service_role";

grant truncate on table "public"."users" to "service_role";

grant update on table "public"."users" to "service_role";


