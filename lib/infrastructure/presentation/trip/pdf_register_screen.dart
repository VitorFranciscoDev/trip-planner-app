import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:trip_planner/entities/trip.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

class PDFRegisterScreen extends StatefulWidget {
  const PDFRegisterScreen({super.key, required this.trip});
  final Trip trip;

  @override
  State<PDFRegisterScreen> createState() => _PDFRegisterScreenState();
}

class _PDFRegisterScreenState extends State<PDFRegisterScreen> {
  final ImagePicker _picker = ImagePicker();
  
  Map<int, File?> personPhotos = {};
  Map<int, List<File>> stopPhotos = {};
  Map<int, TextEditingController> stopDescriptions = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.trip.stops!.length; i++) {
      stopPhotos[i] = [];
      stopDescriptions[i] = TextEditingController();
    }
  }

  @override
  void dispose() {
    stopDescriptions.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _pickPersonPhoto(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        personPhotos[index] = File(image.path);
      });
    }
  }

  Future<void> _pickStopPhoto(int stopIndex) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        stopPhotos[stopIndex]?.add(File(image.path));
      });
    }
  }

  void _removeStopPhoto(int stopIndex, int photoIndex) {
    setState(() {
      stopPhotos[stopIndex]?.removeAt(photoIndex);
    });
  }

  Future<void> _generatePDF() async {
    bool hasAllPersonPhotos = widget.trip.group!.length == personPhotos.length;
    bool hasAllStopData = widget.trip.stops!.every((stop) {
      int index = widget.trip.stops!.indexOf(stop);
      return stopPhotos[index]!.isNotEmpty && 
             stopDescriptions[index]!.text.isNotEmpty;
    });

    if (!hasAllPersonPhotos) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Please add photos for all group members"),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (!hasAllStopData) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text("Please add photos and descriptions for all stops")),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Generating PDF...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final pdf = pw.Document();

      pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('#F5EEDC'),
            ),
            child: pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    widget.trip.title,
                    style: pw.TextStyle(
                      fontSize: 40,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#8B4513'),
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "${widget.trip.start_date} - ${widget.trip.end_date} / ${widget.trip.transport}",
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#8B4513'),
                    ),
                  ),   
                  pw.SizedBox(height: 30),
                  pw.Row(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Container(
                        padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(30),
                        ),
                        child: pw.Text(
                          "Happiness",
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#8B4513'),
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Container(
                        padding: pw.EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(30),
                        ),
                        child: pw.Text(
                          "Travel Memories",
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#8B4513'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Travel Group",
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#8B4513'),
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(widget.trip.group!.length, (index) {
                    final person = widget.trip.group![index];
                    final photo = personPhotos[index];
                    
                    return pw.Container(
                      width: 150,
                      child: pw.Column(
                        children: [
                          pw.Container(
                            width: 120,
                            height: 120,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(15),
                              border: pw.Border.all(
                                color: PdfColor.fromHex('#8B4513'),
                                width: 3,
                              ),
                            ),
                            child: pw.ClipRRect(
                              horizontalRadius: 12,
                              verticalRadius: 12,
                              child: pw.Image(
                                pw.MemoryImage(photo!.readAsBytesSync()),
                                fit: pw.BoxFit.cover,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            person.name,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            "${person.age} years old",
                            style: pw.TextStyle(
                              fontSize: 11,
                              color: PdfColors.grey700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#F5EEDC'),
                    borderRadius: pw.BorderRadius.circular(15),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Text(
                        "Trip Route",
                        style: pw.TextStyle(
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColor.fromHex('#8B4513'),
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 25),
                
                pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: PdfColor.fromHex('#8B4513'),
                        width: 3,
                      ),
                      borderRadius: pw.BorderRadius.circular(15),
                      boxShadow: [
                        pw.BoxShadow(
                          color: PdfColors.grey400,
                          blurRadius: 10,
                          offset: PdfPoint(0, 4),
                        ),
                      ],
                    ),
                    child: pw.ClipRRect(
                      horizontalRadius: 12,
                      verticalRadius: 12,
                      child: widget.trip.map_image != null
                          ? pw.Image(
                              pw.MemoryImage(widget.trip.map_image!),
                              fit: pw.BoxFit.cover,
                            )
                          : pw.Center(
                              child: pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                                  pw.Icon(
                                    pw.IconData(0xe55b),
                                    size: 80,
                                    color: PdfColors.grey400,
                                  ),
                                  pw.SizedBox(height: 15),
                                  pw.Text(
                                    "Map not available",
                                    style: pw.TextStyle(
                                      fontSize: 16,
                                      color: PdfColors.grey600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                
                pw.SizedBox(height: 20),
                
                pw.Container(
                  padding: pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#F5EEDC'),
                    borderRadius: pw.BorderRadius.circular(15),
                    border: pw.Border.all(
                      color: PdfColor.fromHex('#8B4513'),
                      width: 2,
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text(
                            "Cities Visited (${widget.trip.stops!.length})",
                            style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex('#8B4513'),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 12),
                      pw.Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(widget.trip.stops!.length, (index) {
                          final stop = widget.trip.stops![index];
                          return pw.Container(
                            padding: pw.EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              borderRadius: pw.BorderRadius.circular(20),
                              border: pw.Border.all(
                                color: PdfColor.fromHex('#8B4513'),
                                width: 1.5,
                              ),
                            ),
                            child: pw.Row(
                              mainAxisSize: pw.MainAxisSize.min,
                              children: [
                                pw.Container(
                                  width: 24,
                                  height: 24,
                                  decoration: pw.BoxDecoration(
                                    color: PdfColor.fromHex('#8B4513'),
                                    shape: pw.BoxShape.circle,
                                  ),
                                  child: pw.Center(
                                    child: pw.Text(
                                      "${index + 1}",
                                      style: pw.TextStyle(
                                        fontSize: 11,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(width: 10),
                                pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      stop.location,
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColor.fromHex('#8B4513'),
                                      ),
                                    ),
                                    pw.Text(
                                      "${stop.start_date} - ${stop.end_date}",
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                        color: PdfColors.grey700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );

      for (int i = 0; i < widget.trip.stops!.length; i++) {
        final stop = widget.trip.stops![i];
        final photos = stopPhotos[i]!;
        final description = stopDescriptions[i]!.text;

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return [
                pw.Container(
                  padding: pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#F5EEDC'),
                    borderRadius: pw.BorderRadius.circular(15),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 40,
                        height: 40,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          shape: pw.BoxShape.circle,
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            "${i + 1}",
                            style: pw.TextStyle(
                              fontSize: 20,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex('#8B4513'),
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 15),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              stop.location,
                              style: pw.TextStyle(
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex('#8B4513'),
                              ),
                            ),
                            pw.SizedBox(height: 3),
                            pw.Text(
                              "${stop.start_date} - ${stop.end_date}",
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColor.fromHex('#8B4513'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                pw.Text(
                  "Our Experience",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#8B4513'),
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  padding: pw.EdgeInsets.all(15),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Text(
                    description,
                    style: pw.TextStyle(
                      fontSize: 12,
                      lineSpacing: 1.5,
                    ),
                    textAlign: pw.TextAlign.justify,
                  ),
                ),
                pw.SizedBox(height: 20),

                pw.Text(
                  "Photo Gallery",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#8B4513'),
                  ),
                ),
                pw.SizedBox(height: 15),
                
                pw.Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: photos.map((photo) {
                    return pw.Container(
                      width: 170,
                      height: 170,
                      decoration: pw.BoxDecoration(
                        borderRadius: pw.BorderRadius.circular(12),
                        border: pw.Border.all(
                          color: PdfColor.fromHex('#8B4513'),
                          width: 2,
                        ),
                      ),
                      child: pw.ClipRRect(
                        horizontalRadius: 10,
                        verticalRadius: 10,
                        child: pw.Image(
                          pw.MemoryImage(photo.readAsBytesSync()),
                          fit: pw.BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ];
            },
          ),
        );
      }

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Spacer(flex: 2),
                
                  pw.Container(
                    padding: pw.EdgeInsets.all(30),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      shape: pw.BoxShape.circle,
                      boxShadow: [
                        pw.BoxShadow(
                          color: PdfColors.grey400,
                          blurRadius: 20,
                          offset: PdfPoint(0, 5),
                        ),
                      ],
                    ),
                    child: pw.Text(
                      "Trip Planner",
                      style: pw.TextStyle(
                        fontSize: 45,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromHex('#8B4513'),
                      ),
                    ),
                  ),
                  
                  pw.SizedBox(height: 40),
                  
                  pw.Container(
                    width: 60,
                    height: 3,
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#8B4513'),
                      borderRadius: pw.BorderRadius.circular(2),
                    ),
                  ),
                  
                  pw.SizedBox(height: 30),
                  
                  pw.Container(
                    padding: pw.EdgeInsets.symmetric(horizontal: 60),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          '"',
                          style: pw.TextStyle(
                            fontSize: 60,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromHex('#8B4513'),
                          ),
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          "Uma viagem não se mede em milhas, mas em momentos. Cada página deste livreto guarda mais do que paisagens: são sorrisos espontâneos, descobertas inesperadas, conversas que ficaram na alma e silêncios que falaram mais que palavras.",
                          style: pw.TextStyle(
                            fontSize: 14,
                            height: 1.8,
                            color: PdfColors.grey800,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  pw.SizedBox(height: 30),
                  
                  pw.Container(
                    width: 60,
                    height: 3,
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#8B4513'),
                      borderRadius: pw.BorderRadius.circular(2),
                    ),
                  ),
                  
                  pw.Spacer(flex: 2),
                  
                  // Rodapé com info da empresa
                  pw.Container(
                    padding: pw.EdgeInsets.all(20),
                    child: pw.Column(
                      children: [
                        pw.Text(
                          "Vitor Francisco - Trip Planner",
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          "${widget.trip.start_date} - ${widget.trip.end_date}",
                          style: pw.TextStyle(
                            fontSize: 9,
                            color: PdfColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      Navigator.of(context).pop();

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text("PDF generated successfully!"),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Expanded(child: Text("Error generating PDF: ${e.toString()}")),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(
          "Create Trip Booklet",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.book, color: theme.colorScheme.primary, size: 28),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.trip.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: theme.colorScheme.primary,
                              fontFamily: "Times New Roman",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${widget.trip.start_date} - ${widget.trip.end_date}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Group Photos Section
              Row(
                children: [
                  Icon(Icons.group, color: theme.colorScheme.primary, size: 22),
                  SizedBox(width: 8),
                  Text(
                    "Group Members Photos",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Times New Roman",
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(widget.trip.group!.length, (index) {
                    final person = widget.trip.group![index];
                    final hasPhoto = personPhotos[index] != null;
                    
                    return Padding(
                      padding: EdgeInsets.only(bottom: index < widget.trip.group!.length - 1 ? 15 : 0),
                      child: Row(
                        children: [
                          // Photo
                          GestureDetector(
                            onTap: () => _pickPersonPhoto(index),
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: hasPhoto ? null : theme.colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                                image: hasPhoto ? DecorationImage(
                                  image: FileImage(personPhotos[index]!),
                                  fit: BoxFit.cover,
                                ) : null,
                              ),
                              child: hasPhoto ? null : Icon(
                                Icons.add_a_photo,
                                color: theme.colorScheme.primary,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${person.age} years old",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Status
                          Icon(
                            hasPhoto ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: hasPhoto ? Colors.green : Colors.grey[400],
                            size: 24,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 30),

              // Stops Section
              Row(
                children: [
                  Icon(Icons.location_on, color: theme.colorScheme.primary, size: 22),
                  SizedBox(width: 8),
                  Text(
                    "Trip Stops",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Times New Roman",
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              ...List.generate(widget.trip.stops!.length, (index) {
                final stop = widget.trip.stops![index];
                final photos = stopPhotos[index]!;
                final controller = stopDescriptions[index]!;
                
                return Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stop Header
                        Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stop.location,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  Text(
                                    "${stop.start_date} - ${stop.end_date}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        
                        // Photos
                        Text(
                          "Photos",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 10),
                        
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            ...photos.map((photo) {
                              final photoIndex = photos.indexOf(photo);
                              return Stack(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: FileImage(photo),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -5,
                                    right: -5,
                                    child: IconButton(
                                      icon: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.close, color: Colors.white, size: 16),
                                      ),
                                      onPressed: () => _removeStopPhoto(index, photoIndex),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                            
                            // Add Photo Button
                            GestureDetector(
                              onTap: () => _pickStopPhoto(index),
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 2,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  color: theme.colorScheme.primary,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        
                        // Description
                        Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(height: 10),
                        
                        TextField(
                          controller: controller,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "Write about your experience at ${stop.location}...",
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[400],
                            ),
                            filled: true,
                            fillColor: theme.colorScheme.tertiary,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              SizedBox(height: 20),

              // Generate PDF Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _generatePDF,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.picture_as_pdf, size: 24),
                      SizedBox(width: 10),
                      Text(
                        "Generate PDF Booklet",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: "Times New Roman",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}