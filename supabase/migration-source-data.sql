-- מוסיף שדה source_data (jsonb) ל-crm_contacts כדי לשמור את השדות הייחודיים
-- של כל קמפיין/דף נחיתה בצורה מובנית, לסינון ואוטומציות (בנוסף ל-source ו-notes).
-- להריץ פעם אחת ב-SQL editor של POLICYHUB (פרויקט rymrafskckljgirrejqu). אידמפוטנטי.

alter table public.crm_contacts add column if not exists source_data jsonb;

-- אינדקס GIN לסינון מהיר לפי מפתחות בתוך ה-jsonb
-- (למשל: where source_data->>'area' = 'גוש דן').
create index if not exists crm_contacts_source_data_idx
  on public.crm_contacts using gin (source_data);

-- אינדקס על source לסינון/תצוגה per קמפיין (אם עוד לא קיים).
create index if not exists crm_contacts_source_idx
  on public.crm_contacts (source);
