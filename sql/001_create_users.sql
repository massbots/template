-- +goose Up

create table users (
    created_at  timestamptz not null default now(),
    updated_at  timestamptz not null default now(),
    id          bigint      primary key
);