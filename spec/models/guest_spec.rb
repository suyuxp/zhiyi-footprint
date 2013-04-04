# -*- coding: utf-8 -*-
require 'spec_helper'

describe Guest do

  before(:each) do
    @example = { app: 'ccde-stmis', name: '科技管理系统' }
  end

  it "授权应用的注册" do
    Guest.create!(@example).name.should be_true
  end

  it "不允许重复注册" do
    Guest.create!(@example)
    expect { Guest.create!(@example) }.to raise_error
  end
end
