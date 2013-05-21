# -*- coding: utf-8 -*-
require 'spec_helper'

describe Guest do

  before(:each) do
    @example = { app: 'ccde-stmis', name: '科技管理系统' }
    @invalids = [ { app: 'st3', name: '科技管理系统' },        # 应用名称太短
                  { app: 'ccde第2版', name: '科技管理系统' }, # 应用名称中带中文，非法字符
                  { app: '3ccde-stmis', name: '科技管理系统' }, # 不能以数字开头
                  { app: '-ccde-stmis', name: '科技管理系统' }, # 不能以中划线开头
                  { app: 'ccde-stmis-', name: '科技管理系统' }, # 不能以中划线结尾
                  { app: 'ccde-stmis-ccde-stmis-ccde-stmis-ccde-stmis', name: '科技管理系统' }, # 过长，超过32位字符
                ]
  end

  it "授权应用的注册" do
    Guest.create!(@example).name.should be_true
  end

  it "不允许重复注册" do
    Guest.create!(@example)
    expect { Guest.create!(@example) }.to raise_error
  end

  it "应用名格式不符的都是不合法的" do
    @invalids.each do |guest|
      expect { Guest.create!(guest) }.to raise_error
    end
  end
end
