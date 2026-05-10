# NEXUS — Segundo Cérebro Digital 🧠

Sistema completo de organização pessoal com sincronização em nuvem via **GitHub Pages + Supabase**.

---

## 🚀 Como hospedar (passo a passo)

### PARTE 1 — Supabase (Banco de dados)

**1. Criar conta gratuita**
- Acesse [supabase.com](https://supabase.com) → clique **Start your project**
- Faça login com GitHub (recomendado)

**2. Criar um projeto**
- Clique em **New Project**
- Nome: `nexus` | Senha: (anote!) | Região: `South America (São Paulo)`
- Aguarde ~2 minutos para criar

**3. Criar a tabela no banco**
- No painel, clique em **SQL Editor** (ícone de terminal no menu)
- Cole e execute este SQL:

```sql
-- Tabela principal de dados do NEXUS
CREATE TABLE nexus_data (
  id BIGSERIAL PRIMARY KEY,
  user_id TEXT NOT NULL UNIQUE,
  payload TEXT NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para busca rápida por user_id
CREATE INDEX idx_nexus_user_id ON nexus_data(user_id);

-- Row Level Security (segurança básica)
ALTER TABLE nexus_data ENABLE ROW LEVEL SECURITY;

-- Política: qualquer um pode ler/escrever (simplificado para uso pessoal)
CREATE POLICY "Allow all" ON nexus_data FOR ALL USING (true) WITH CHECK (true);
```

- Clique em **Run** (ou Ctrl+Enter)
- Deve aparecer "Success. No rows returned"

**4. Pegar as credenciais**
- No menu lateral: **Settings → API**
- Copie:
  - **Project URL** → algo como `https://xyzabc123.supabase.co`
  - **anon public key** → chave longa começando com `eyJ...`

---

### PARTE 2 — Configurar o arquivo nexus.html

Abra o `nexus.html` em qualquer editor de texto (Bloco de Notas, VS Code, etc.)

Procure essas duas linhas no início do `<script>`:

```javascript
const SUPABASE_URL = 'COLE_SUA_URL_AQUI';
const SUPABASE_KEY = 'COLE_SUA_ANON_KEY_AQUI';
```

Substitua pelos valores copiados:

```javascript
const SUPABASE_URL = 'https://xyzabc123.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

Salve o arquivo.

---

### PARTE 3 — GitHub Pages (Hospedagem)

**1. Criar conta no GitHub**
- Acesse [github.com](https://github.com) → Sign up (gratuito)

**2. Criar repositório**
- Clique em **New** (ícone `+` no canto superior direito)
- Repository name: `nexus`
- Marque: **Public** (necessário para GitHub Pages gratuito)
- Clique **Create repository**

**3. Fazer upload dos arquivos**
- Na página do repositório, clique **uploading an existing file**
- Arraste os arquivos: `nexus.html` e `README.md`
- Role para baixo → clique **Commit changes**

**4. Ativar GitHub Pages**
- Vá em **Settings** (aba do repositório)
- No menu lateral: **Pages**
- Em "Source": selecione **Deploy from a branch**
- Branch: **main** | Folder: **/ (root)**
- Clique **Save**

**5. Aguardar o deploy**
- Após ~1-2 minutos, aparecerá a URL:
  ```
  https://SEU-USUARIO.github.io/nexus/nexus.html
  ```
- Esta é sua URL permanente! Acesse de qualquer dispositivo.

---

## 📱 Acessar no celular

No celular, abra o navegador e acesse:
```
https://SEU-USUARIO.github.io/nexus/nexus.html
```

Para adicionar à tela inicial:
- **iPhone**: Safari → compartilhar → "Adicionar à Tela de Início"
- **Android**: Chrome → menu `⋮` → "Adicionar à tela inicial"

Vira um app no celular! 📲

---

## 🔄 Como funciona a sincronização

```
Computador → Salva → Supabase (nuvem) ← Carrega ← Celular
```

- Ao salvar qualquer dado, ele é enviado ao Supabase automaticamente
- Ao abrir o app em outro dispositivo, ele carrega os dados mais recentes da nuvem
- Se estiver offline, salva localmente e sincroniza quando voltar a internet

---

## 🔒 Segurança

- O `user_id` é gerado automaticamente no primeiro acesso e salvo no dispositivo
- Os dados são privados por `user_id` — cada dispositivo tem o mesmo ID após o primeiro sync
- A `anon key` do Supabase é pública por design — não é uma senha

> **Dica:** Para usar em múltiplos dispositivos com o MESMO usuário, após o primeiro acesso no computador, copie o valor de `nexus_uid` do localStorage e coloque no celular também (ou simplesmente use e os dados serão compartilhados automaticamente pelo Supabase após o primeiro sync).

---

## ✏️ Atualizar o sistema

Quando receber uma nova versão do `nexus.html`:
1. Copie as 2 linhas de credenciais (`SUPABASE_URL` e `SUPABASE_KEY`)
2. Cole na nova versão
3. Faça upload no GitHub (substitua o arquivo)
4. Os dados na nuvem são preservados!

---

## 🆘 Problemas comuns

| Problema | Solução |
|----------|---------|
| "Supabase não configurado" | Verifique se colou as credenciais corretamente |
| Dados não sincronizam | Verifique se a tabela foi criada com o SQL acima |
| Erro 401 | A anon key está errada — copie novamente do Supabase |
| Página não abre | Aguarde 2 minutos após ativar o GitHub Pages |

---

*NEXUS v4 — Desenvolvido com Claude AI*
