class AccessGrouping < ActiveRecord::Base
  belongs_to :access_group
  after_create :generate_notification
  belongs_to :article

  def generate_notification
    body = "<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"> <soap12:Body> <Insert_Document xmlns=\"http://tempuri.org/\"> <UserName>tehranuni</UserName> <Password>98765432100</Password> <ownerDepartmentId>4BE6D74C-56A7-4871-B13F-51D844D5DC51</ownerDepartmentId> <ownerPersonnelId>3099FF0E-B897-4FB4-A0BF-507ACAABE1D0</ownerPersonnelId> <Subject>#{article.title}</Subject> <Description>#{ActionView::Base.full_sanitizer.sanitize(article.content)}</Description> <docDate></docDate> <keyword></keyword> <SecurityId>Normal</SecurityId> <UrgencyId>Normal</UrgencyId> <LetterType>Taypi</LetterType> <ErrStatus>0</ErrStatus> <ErrMessage>-</ErrMessage> <ErrFunctionName>-</ErrFunctionName> </Insert_Document> </soap12:Body> </soap12:Envelope>"
    HTTParty.post('http://192.168.112.185/IstgInternalDocWebService/InternalDocuments.asmx', body: body,
                                                                                             headers: { 'Content-Type' => 'text/xml; charset=utf-8' })

    return unless notify

    # Notification.create(user_id: self.user_id, notifiable_type: "Article", notifiable_id: self.article_id, notification_type: "access_grouping", emmiter_id: self.user_id)
    users = []
    for role in access_group.roles
      for user in role.users
        users << user.id
      end
    end
    uniq_users = users.uniq
    for user in uniq_users
      # prev = AccessGrouping.where('user_id = ? and article_id = ? and created_at < ?', user, self.article_id, 1.day.ago).first
      # if prev.blank?
      if user == user_id && !user.profile.blank? && !user.profile.dabir_department_id.blank? && !user.profile.dabir_personnel_id.blank?
        body = "<?xml version=\"1.0\" encoding=\"utf-8\"?> <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\"> <soap12:Body> <Insert_Document xmlns=\"http://tempuri.org/\"> <UserName>tehranuni</UserName> <Password>98765432100</Password> <ownerDepartmentId>#{user.profile.dabir_department_id}</ownerDepartmentId> <ownerPersonnelId>#{user.profile.dabir_personnel_id}</ownerPersonnelId> <Subject>#{article.title}</Subject> <Description>#{ActionView::Base.full_sanitizer.sanitize(article.content)}</Description> <docDate></docDate> <keyword></keyword> <SecurityId>Normal</SecurityId> <UrgencyId>Normal</UrgencyId> <LetterType>Taypi</LetterType> <ErrStatus>0</ErrStatus> <ErrMessage>-</ErrMessage> <ErrFunctionName>-</ErrFunctionName> </Insert_Document> </soap12:Body> </soap12:Envelope>"
        HTTParty.post('http://192.168.112.185/IstgInternalDocWebService/InternalDocuments.asmx', body: body,
                                                                                                 headers: { 'Content-Type' => 'text/xml; charset=utf-8' })

      end

      Notification.create(user_id: user, notifiable_type: 'AccessGrouping', notifiable_id: id,
                          notification_type: 'access_grouping', emmiter_id: user_id)
      # end
    end
  end
end
