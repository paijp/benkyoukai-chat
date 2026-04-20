# 勉強会チャット (GitHub Pages + Supabase + Resend)

GAS版から移行した、勉強会フォローアップチャットアプリです。

## アーキテクチャ

| 役割 | 技術 |
|------|------|
| フロントエンド | GitHub Pages (静的HTML) |
| データベース | Supabase (PostgreSQL) |
| バックエンドAPI | Supabase Edge Functions |
| メール送信 | Resend |

## セットアップ

### 1. Supabase
- `supabase/migration.sql` をSQL Editorで実行済み
- Edge Function `api` はデプロイ済み
- 以下の環境変数をEdge Functions設定で追加:
  - `RESEND_API_KEY`
  - `RESEND_FROM_EMAIL`
  - `APP_URL` (GitHub PagesのURL)

### 2. GitHub Secrets
`Settings > Secrets > Actions` で追加:
- `SUPABASE_FUNCTION_URL`: `https://ytkatwztgejatuiaqdhr.supabase.co/functions/v1/api`

### 3. 参加者登録
Supabase Table EditorまたはSQL Editorで登録:
```sql
INSERT INTO participants (name, email, token, role)
VALUES ('山田太郎', 'yamada@example.com', gen_random_uuid()::text, '主催者');
```

### 4. アクセス
`https://paijp.github.io/benkyoukai-chat/?t=<token>`
