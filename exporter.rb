require 'minisky'
require 'json'

$aegis = "did:plc:j67mwmangcbxch7knfm7jo2b"

$lists = {
    'antisemitism' => '3kbqy62rg542l',
    'bots-spam' => '3kbqubqkpge2b',
    'boundary-violation' => '3kbhe7y3svr2q',
    'covid-denialism-misinformation' => '3kbha2bcxlr2h',
    'engagement-hacking' => '3kbhefllrsl2d',
    'intolerance-sw' => '3kbquqvvjwr2l',
    'misogyny' => '3ksv2iipzkc2l',
    'political-extremism' => '3kbgvjuahr72s',
    'queerphobia' => '3kbqvhrpar22i',
    'racial-intolerance' => '3kbqycxbqdy2y',
    'sockpuppeting' => '3kbhagfp4ja2p',
    'transphobia' => '3kbgrrtucxl2p',
    'trolling' => '3kbqwyc2fu32n',
    'dni' => '3kbqz4pirti2t'
}

api = Minisky.new('public.api.bsky.app', nil)

list_data = []

$lists.keys.each do |list|
    puts list
    data = {}
    data["name"] = list
    entries = []
    api_list_data = api.fetch_all('app.bsky.graph.getList', { list: "at://#{$aegis}/app.bsky.graph.list/#{$lists[list]}" }, field: 'items')
    api_list_data.each do |listitem|
        entries.push listitem["subject"]["did"]
        # puts listitem["subject"]["did"]
    end
    #puts entries
    data["entries"] = entries
    list_data.push data
    puts list_data
end

File.open('list_data.json', 'w') do |f|
    f.write(list_data.to_json)
end