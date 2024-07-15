def create_one_script():
    """ create one big script with all queries """

    files = [
        'delete.cypher',
        'nodes.cypher',
        'indexes.cypher',
        'constrains.cypher',
        'relations.cypher',
    ]

    with open('prepare_database.cypher', 'w') as script_file:
        for file_name in files:
            with open(file_name) as f:
                script_file.write(f.read())


if __name__ == '__main__':
    create_one_script()
