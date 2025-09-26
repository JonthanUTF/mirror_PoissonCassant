import csv
import json
import sys
import os

def csv_to_json(csv_path, json_path):
    if not os.path.exists(csv_path):
        print(f"Erreur : le fichier CSV n'existe pas : {csv_path}")
        return

    data = []

    # Lire le CSV
    with open(csv_path, newline='', encoding='utf-8') as f:
        reader = csv.DictReader(f)  # Utilise les noms de colonnes
        for row in reader:
            data.append(row)

    # Écrire le JSON
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

    print(f"JSON créé avec succès : {json_path}")

# --- Utilisation depuis la ligne de commande ---
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage : python csv_to_json.py <chemin_csv> <chemin_json_sortie>")
    else:
        csv_path = sys.argv[1]
        json_path = sys.argv[2]
        csv_to_json(csv_path, json_path)
