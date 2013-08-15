class AddNewFileLogsToOldFiles < ActiveRecord::Migration
  def up
    FileLog.all.each do |file_log|
      file_log.destroy
    end
    
    
    UserFile.all.each do |user_file|
      FileLog.create_log(user_file)
      file_log = user_file.file_log
      file_log.created_at = user_file.created_at
      file_log.save
      attachment_name = user_file.attachment.file.filename
      FileRevision.create(:user_file_id => user_file.id, :file_log_id => file_log.id, :file_name => attachment_name) if user_file.name != attachment_name
      FileRevision.create_revision(user_file)
    end
  end
  
  
  
  def down
    
  end
end