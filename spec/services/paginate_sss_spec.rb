# -*- coding: utf-8 -*-
require 'spec_helper'

describe PaginateSss do

  let(:params) do
    {"utf8" => "✓",
     "q" => "something nice",
     "commit" => "image search",
     "action" => "show",
     "controller" => "search" }
  end

  let(:photo_album) do
    album = double "photo_album"
    allow(album).to receive(:page) { "5" }
    allow(album).to receive(:pages) { "85" }
    album
  end

  let(:paginator) { PaginateSss.new(photo_album, params, "searchy")}

  it "returns the current page" do
    expect(paginator.page).to eq 5
  end

  it "returns the total pages" do
    expect(paginator.pages).to eq 85
  end


  describe "#url_for" do

    it "returns a url for the passed path" do
      url = paginator.url_for(1)
      expect(url).to include "/searchy?"
    end

    it "returns the url for the page specified" do
      url = paginator.url_for(5)
      expect(url).to include "page=5"
    end

    it "returns the url for the last page" do
      url = paginator.url_for(:last)

      expect(url).to include "page=85"
    end

    it "returns the url for the first page" do
      url = paginator.url_for(:first)

      expect(url).to include "page=1"
    end

  end

  it "returns the start page for pagination" do
    expect(paginator.start_page).to eq 1
  end

  it "returns the end page for pagination" do
    expect(paginator.end_page).to eq 10
  end

end
