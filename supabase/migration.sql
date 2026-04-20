-- =============================================
-- 勉強会チャット - Supabase マイグレーション
-- =============================================

-- participants テーブル
create table if not exists participants (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text not null,
  token text not null unique,
  last_seen_at timestamptz,
  role text not null default '参加者',
  created_at timestamptz default now()
);

-- posts テーブル
create table if not exists posts (
  id text primary key,
  author_token text not null references participants(token),
  kind text not null default 'qa',
  body text not null,
  status text default '',
  created_at timestamptz default now()
);

-- comments テーブル
create table if not exists comments (
  id uuid primary key default gen_random_uuid(),
  post_id text not null references posts(id),
  author_token text not null references participants(token),
  kind text not null default '参加者',
  body text not null,
  created_at timestamptz default now()
);

create index if not exists idx_posts_created_at on posts(created_at desc);
create index if not exists idx_comments_post_id on comments(post_id);
create index if not exists idx_participants_token on participants(token);

alter table participants disable row level security;
alter table posts disable row level security;
alter table comments disable row level security;
