class LoadMailer < ApplicationMailer
  def dispatched(load)
    @load = load

    mail to: Figaro.env.LOAD_MAILER_RECIPIENTS,
         subject: I18n.t('load_mailer.dispatched.subject')
  end

  def shipped(load)
    @load = load

    mail to: Figaro.env.LOAD_MAILER_RECIPIENTS,
         subject: I18n.t('load_mailer.shipped.subject')
  end
end
