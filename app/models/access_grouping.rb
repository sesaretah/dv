class AccessGrouping < ActiveRecord::Base
  belongs_to :access_group
  after_create :generate_notification
  belongs_to :article

  
  def generate_notification
    return if !notify && !notify_automation

    # Notification.create(user_id: self.user_id, notifiable_type: "Article", notifiable_id: self.article_id, notification_type: "access_grouping", emmiter_id: self.user_id)
    users = []
    for role in access_group.roles
      for user in role.users
        users << user.id
      end
    end
    uniq_users = users.uniq
    for uniq_user_id in uniq_users
      # prev = AccessGrouping.where('user_id = ? and article_id = ? and created_at < ?', user, self.article_id, 1.day.ago).first
      # if prev.blank?
      user = User.find(uniq_user_id)
      if notify_automation && uniq_user_id == user_id && !user.profile.blank? && !user.profile.dabir_department_id.blank? && !user.profile.dabir_personnel_id.blank?
        body = "<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"> <soap12:Body> <Insert_Document xmlns=\"http://tempuri.org/\"> <UserName>tehranuni</UserName> <Password>98765432100</Password> <ownerDepartmentId>#{user.profile.dabir_department_id}</ownerDepartmentId> <ownerPersonnelId>#{user.profile.dabir_personnel_id}</ownerPersonnelId> <Subject> ابلاغ #{article.title}</Subject> <Description> <![CDATA[ <html><body> با سلام
        <br />
        احتراماً، به پيوست
        <a class='btn btn-success mb-5' href='https://divan.ut.ac.ir/pdfs/#{article.id}/#{article.publish_uuid}.pdf'>#{article.title}</a>
        جهت استحضار و اقدام مقتضي ابلاغ مي‌گردد.
        
          </body></html> ]]> </Description> <docDate></docDate> <keyword></keyword> <SecurityId>Normal</SecurityId> <UrgencyId>Normal</UrgencyId> <LetterType>Taypi</LetterType> <ErrStatus>0</ErrStatus> <ErrMessage>-</ErrMessage> <ErrFunctionName>-</ErrFunctionName> </Insert_Document> </soap12:Body> </soap12:Envelope>"
        HTTParty.post('http://192.168.112.185/IstgInternalDocWebService/InternalDocuments.asmx', body: body,
                                                                                                 headers: { 'Content-Type' => 'text/xml; charset=utf-8' })

      end
      if notify
        Notification.create(user_id: uniq_user_id, notifiable_type: 'AccessGrouping', notifiable_id: id,
                          notification_type: 'access_grouping', emmiter_id: user_id)
      end
    end
  end
end
