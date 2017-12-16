class CheckGCPProjectBillingService
  def execute(token)
    client = GoogleApi::CloudPlatform::Client.new(token, nil)
    client.projects_list.any? do |project|
      client.projects_get_billing_info(project.name).billingEnabled
    end
  end
end
