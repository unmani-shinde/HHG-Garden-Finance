import * as Papa from 'papaparse';
import React, { useState } from 'react';

// Define the type for the CSV row
type CSVRow = {
  [key: string]: string;
};

const CSVReader: React.FC = () => {
  const [csvData, setCsvData] = useState<CSVRow[]>([]);
  const [gpas, setGpas] = useState<number[]>([]);

  // Function to handle file upload
  const handleFileUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];

    if (file) {
      Papa.parse<CSVRow>(file, {
        header: true,
        complete: (results: Papa.ParseResult<CSVRow>) => {
          setCsvData(results.data);
          computeGPAs(results.data);
        },
        error: (error: any) => {
          console.error('Error reading CSV file:', error);
        },
      });
    }
  };

  // Function to compute GPA for each row
  const computeGPAs = (data: CSVRow[]) => {
    const newGpas = data.map((row) => {
      const grades = [
        parseFloat(row["english.grade"]),
        parseFloat(row["math.grade"]),
        parseFloat(row["sciences.grade"]),
        parseFloat(row["language.grade"]),
      ];

      const sumOfGrades = grades.reduce((acc, grade) => acc + grade, 0);
      const gpa = sumOfGrades / grades.length;
      return gpa;
    });
    setGpas(newGpas);
  };

  return (
    <div>
      <h1>CSV Reader</h1>
      <input type="file" accept=".csv" onChange={handleFileUpload} />
      {csvData.length > 0 && (
        <div>
          <h2>CSV Data</h2>
          {csvData.map((row, index) => (
            <div key={index}>
              <pre>{JSON.stringify(row, null, 2)}</pre>
              <p>GPA: {gpas[index].toFixed(2)}</p>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default CSVReader;
