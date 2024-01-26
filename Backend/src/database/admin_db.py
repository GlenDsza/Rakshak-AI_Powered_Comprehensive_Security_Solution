from src.establish_db_connection import database

admins = database.Admins

def get_admin_by_id(id):
    try:
        document = admins.find_one({"id": id})
        if document == None:
            return {"ERROR":"NO SUCH ADMIN EXISTS"}
        else:
            del document['_id']
            del document['password']
            return {"SUCCESS": document}
    except Exception as e:
        print(e)
        return {"ERROR":"SOME ERROR OCCURRED"}