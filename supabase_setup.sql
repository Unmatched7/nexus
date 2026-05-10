-- ═══════════════════════════════════════════════
--  NEXUS — Setup do banco de dados no Supabase
--  Cole este SQL no SQL Editor do Supabase e clique Run
-- ═══════════════════════════════════════════════

-- 1. Criar tabela principal
CREATE TABLE IF NOT EXISTS nexus_data (
  id          BIGSERIAL PRIMARY KEY,
  user_id     TEXT NOT NULL UNIQUE,
  payload     TEXT NOT NULL,
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Índice para performance
CREATE INDEX IF NOT EXISTS idx_nexus_user_id ON nexus_data(user_id);

-- 3. Habilitar segurança por linha
ALTER TABLE nexus_data ENABLE ROW LEVEL SECURITY;

-- 4. Política de acesso (uso pessoal — sem autenticação)
DROP POLICY IF EXISTS "Allow all" ON nexus_data;
CREATE POLICY "Allow all" ON nexus_data
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- 5. Função para atualizar timestamp automaticamente
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 6. Trigger para atualizar timestamp ao salvar
DROP TRIGGER IF EXISTS set_updated_at ON nexus_data;
CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON nexus_data
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ✅ Pronto! Execute este SQL e configure as credenciais no nexus.html
