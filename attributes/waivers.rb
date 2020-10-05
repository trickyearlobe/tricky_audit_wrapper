# An example waiver which will be written to the waivers file by the default recipe.
# You can add more of these in any of the attribute files of any cookbook
default[cookbook_name]['waivers']['example-control-global-warming'] = {
  expiration_date: "2040-01-01",
  run: false,
  justification: "Global warming will not be under control until at least 2040"
}