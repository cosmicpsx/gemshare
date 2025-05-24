// Methode 1: Mit CORS-Proxy (für Browser-Umgebung)
async function fetchVertretungsplanWithProxy() {
    const proxyUrl = 'https://cors-anywhere.herokuapp.com/';
    const targetUrl = 'https://www.goethe.flensburg.de/files/vertretung/Leh_Dateien/Dateien/subst_001.htm';
    
    try {
        const response = await fetch(proxyUrl + targetUrl);
        const html = await response.text();
        return parseVertretungsplan(html);
    } catch (error) {
        console.error('Fehler beim Laden der Seite:', error);
        return [];
    }
}

// Methode 2: Für Node.js Umgebung (mit axios und cheerio)
// npm install axios cheerio
/*
const axios = require('axios');
const cheerio = require('cheerio');

async function fetchVertretungsplanNodeJS() {
    try {
        const response = await axios.get('https://www.goethe.flensburg.de/files/vertretung/Leh_Dateien/Dateien/subst_001.htm');
        return parseVertretungsplanCheerio(response.data);
    } catch (error) {
        console.error('Fehler beim Laden der Seite:', error);
        return [];
    }
}

function parseVertretungsplanCheerio(html) {
    const $ = cheerio.load(html);
    const data = [];
    
    // Haupttabelle finden und Zeilen extrahieren
    $('table').each((tableIndex, table) => {
        $(table).find('tr').each((rowIndex, row) => {
            const cells = [];
            $(row).find('td, th').each((cellIndex, cell) => {
                cells.push($(cell).text().trim());
            });
            if (cells.length > 0) {
                data.push(cells);
            }
        });
    });
    
    return data;
}
*/

// Parser-Funktion für Browser-Umgebung
function parseVertretungsplan(html) {
    // DOM Parser erstellen
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, 'text/html');
    
    const data = [];
    
    // Alle Tabellen finden
    const tables = doc.querySelectorAll('table');
    
    tables.forEach((table, tableIndex) => {
        const tableData = [];
        const rows = table.querySelectorAll('tr');
        
        rows.forEach((row, rowIndex) => {
            const cells = [];
            const cellElements = row.querySelectorAll('td, th');
            
            cellElements.forEach(cell => {
                cells.push(cell.textContent.trim());
            });
            
            if (cells.length > 0) {
                tableData.push(cells);
            }
        });
        
        if (tableData.length > 0) {
            data.push({
                tableIndex: tableIndex,
                data: tableData
            });
        }
    });
    
    return data;
}

// Erweiterte Parser-Funktion mit besserer Strukturierung
function parseVertretungsplanStructured(html) {
    const parser = new DOMParser();
    const doc = parser.parseFromString(html, 'text/html');
    
    const result = {
        title: '',
        date: '',
        tables: []
    };
    
    // Titel und Datum extrahieren
    const titleElement = doc.querySelector('h1, h2, h3, .title, .header');
    if (titleElement) {
        result.title = titleElement.textContent.trim();
    }
    
    // Datum suchen (häufige Formate)
    const text = doc.body.textContent;
    const dateRegex = /(\d{1,2}\.?\d{1,2}\.?\d{2,4})|(\d{2,4}-\d{1,2}-\d{1,2})/g;
    const dateMatch = text.match(dateRegex);
    if (dateMatch) {
        result.date = dateMatch[0];
    }
    
    // Tabellen verarbeiten
    const tables = doc.querySelectorAll('table');
    
    tables.forEach((table, index) => {
        const tableObj = {
            index: index,
            headers: [],
            rows: []
        };
        
        // Header extrahieren
        const headerRow = table.querySelector('tr');
        if (headerRow) {
            const headerCells = headerRow.querySelectorAll('th, td');
            headerCells.forEach(cell => {
                tableObj.headers.push(cell.textContent.trim());
            });
        }
        
        // Datenzeilen extrahieren
        const dataRows = table.querySelectorAll('tr');
        dataRows.forEach((row, rowIndex) => {
            if (rowIndex === 0 && tableObj.headers.length > 0) return; // Header überspringen
            
            const cells = [];
            const cellElements = row.querySelectorAll('td, th');
            
            cellElements.forEach(cell => {
                cells.push(cell.textContent.trim());
            });
            
            if (cells.length > 0 && cells.some(cell => cell !== '')) {
                tableObj.rows.push(cells);
            }
        });
        
        if (tableObj.rows.length > 0 || tableObj.headers.length > 0) {
            result.tables.push(tableObj);
        }
    });
    
    return result;
}

// Hilfsfunktion zum Filtern der Vertretungsdaten
function filterVertretungsdaten(data) {
    if (!data.tables || data.tables.length === 0) return [];
    
    // Die Haupttabelle ist meist die größte oder die erste mit relevanten Daten
    const mainTable = data.tables.find(table => 
        table.headers.some(header => 
            header.toLowerCase().includes('stunde') || 
            header.toLowerCase().includes('klasse') ||
            header.toLowerCase().includes('fach') ||
            header.toLowerCase().includes('lehrer')
        )
    ) || data.tables[0];
    
    return mainTable ? mainTable.rows : [];
}

// Hauptfunktion zum Ausführen
async function getVertretungsplan() {
    try {
        console.log('Lade Vertretungsplan...');
        
        // Methode 1: Mit Proxy versuchen
        const data = await fetchVertretungsplanWithProxy();
        
        if (data.length > 0) {
            console.log('Gefundene Tabellen:', data.length);
            console.log('Erste Tabelle:', data[0]);
            return data;
        } else {
            console.log('Keine Daten gefunden');
            return [];
        }
        
    } catch (error) {
        console.error('Fehler:', error);
        return [];
    }
}

// Erweiterte Ausführung mit strukturierten Daten
async function getVertretungsplanStructured() {
    try {
        const proxyUrl = 'https://cors-anywhere.herokuapp.com/';
        const targetUrl = 'https://www.goethe.flensburg.de/files/vertretung/Leh_Dateien/Dateien/subst_001.htm';
        
        const response = await fetch(proxyUrl + targetUrl);
        const html = await response.text();
        const structured = parseVertretungsplanStructured(html);
        
        console.log('Strukturierte Daten:', structured);
        
        // Nur die Vertretungsdaten zurückgeben
        const vertretungsdaten = filterVertretungsdaten(structured);
        console.log('Gefilterte Vertretungsdaten:', vertretungsdaten);
        
        return vertretungsdaten;
        
    } catch (error) {
        console.error('Fehler:', error);
        return [];
    }
}
getVertretungsplanStructured().then(data => console.log('Strukturiertes Ergebnis:', data));
// Beispiel-Aufruf:
// getVertretungsplan().then(data => console.log('Ergebnis:', data));
// oder
// getVertretungsplanStructured().then(data => console.log('Strukturiertes Ergebnis:', data));
