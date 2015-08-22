# -*- coding: utf-8 -*-

# スパブロキメるプラグイン
Plugin.create(:report_spam) do
  def spamblock(screen_name)
    (Service.primary.twitter/'users/report_spam').message({:screen_name => screen_name})
    (Service.primary.twitter/'blocks/create').message({:screen_name => screen_name})
  end
  
  command(:block_and_report_spam,
          name: 'スパブロ',
          condition: Plugin::Command[:HasOneMessage],
          visible: true,
          role: :timeline)do |opt|
    message = opt.messages.first
    screen_name = message.user[:idname]
    spamblock(screen_name)
  end
end
