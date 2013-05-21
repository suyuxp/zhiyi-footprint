# -*- coding: utf-8 -*-

FactoryGirl.define do

  factory :guest do
    app 'ccde-stmis'
    name '科技管理系统'
  end


  factory :review, class: Recorder do
    association :guest, factory: :guest
    talker '1'
    task 'assign'
    model_name 'subject'
    model_id '1'
    content '请尽快完成相关工作'
    brief '同意'
  end
end
