# corpus.py
from pathlib import Path
from typing import Dict, List, Set
import os

class PDFStorageSystem:
    def __init__(self, base_dir: str = "database"):
        self.base_path = Path(base_dir)
        self._scan_structure()

    def _scan_structure(self):
        self.structure = {}
        self.available_grades = set()
        self.available_subjects = set()

        # Scan all grade directories
        for grade_dir in self.base_path.glob("grade_*"):
            grade_num = int(grade_dir.name.split("_")[1])
            self.available_grades.add(grade_num)
            
            # Store information about PDFs in this grade
            self.structure[grade_num] = {}
            
            # Scan all PDFs in the grade directory
            for pdf_file in grade_dir.glob("*.pdf"):
                # Extract subject from filename (assuming format: subject_grade.pdf)
                subject = pdf_file.stem.split("_")[0]
                self.available_subjects.add(subject)
                
                self.structure[grade_num][subject] = {
                    'path': str(pdf_file),
                    'filename': pdf_file.name
                }

    def get_available_grades(self) -> Set[int]:
        return sorted(list(self.available_grades))

    def get_subjects_for_grade(self, grade: int) -> List[str]:
        if grade in self.structure:
            return sorted(list(self.structure[grade].keys()))
        return []

    def get_all_subjects(self) -> List[str]:
        return sorted(list(self.available_subjects))

    def get_pdf_path(self, grade: int, subject: str) -> str:
        if grade in self.structure and subject in self.structure[grade]:
            return self.structure[grade][subject]['path']
        return None

    def list_all_pdfs(self) -> Dict:
        return self.structure

    def check_pdf_exists(self, grade: int, subject: str) -> bool:
        return grade in self.structure and subject in self.structure[grade]