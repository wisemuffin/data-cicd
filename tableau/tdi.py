import tableaudocumentapi as TDI

sourceTDS = TDI.Datasource.from_file(
    "./tableau/tab_downloads/datasources/Orders Prod.tds"
)
connections = sourceTDS.connections
connections[0].dbname = "DBT_FUNDAMENTALS_PROD_CLONE"
# connections[0]._connectionXML.attrib["schema"] = "PR_1614499491"

# create file
sourceTDS.save_as("./tableau/tab_downloads/datasources/Orders Prod Clone.tds")


print([c for c in connections])
fields = sourceTDS.fields

print("----------------------------------------------------------")
print("--- {} total fields in this datasource".format(len(sourceTDS.fields)))
print("----------------------------------------------------------")
for count, field in enumerate(sourceTDS.fields.values()):
    print("{:>4}: {} is a {}".format(count + 1, field.name, field.datatype))
    blank_line = False
    if field.calculation:
        print("      the formula is {}".format(field.calculation))
        blank_line = True
    if field.default_aggregation:
        print("      the default aggregation is {}".format(field.default_aggregation))
        blank_line = True
    if field.description:
        print("      the description is {}".format(field.description))

    if blank_line:
        print("")
print("----------------------------------------------------------")

print("----------------------------------------------------------")
print("-- Info for our .tds:")
print("--   name:\t{0}".format(sourceTDS.name))
print("--   version:\t{0}".format(sourceTDS.version))
print("----------------------------------------------------------")

