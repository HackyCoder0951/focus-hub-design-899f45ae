create or replace function leave_group(p_chat_id uuid, p_user_id uuid)
returns void as $$
declare
  admin_count integer;
  member_count integer;
  new_admin_id uuid;
begin
  -- Remove the user from chat_members
  delete from chat_members where chat_id = p_chat_id and user_id = p_user_id;

  -- Check if any admins remain
  select count(*) into admin_count from chat_members where chat_id = p_chat_id and is_admin = true;

  if admin_count = 0 then
    -- Promote the earliest-joined member to admin, if any remain
    select user_id into new_admin_id from chat_members where chat_id = p_chat_id order by joined_at asc limit 1;
    if new_admin_id is not null then
      update chat_members set is_admin = true where chat_id = p_chat_id and user_id = new_admin_id;
    end if;
  end if;

  -- Check if any members remain
  select count(*) into member_count from chat_members where chat_id = p_chat_id;
  if member_count = 0 then
    -- Delete all messages and the chat itself
    delete from chat_messages where chat_id = p_chat_id;
    delete from chats where id = p_chat_id;
  end if;
end;
$$ language plpgsql security definer; 