class Listing

  include Gmaps4rails::ActsAsGmappable
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Timestamps
  
  #has_many :listing_images, :dependent => :destroy
  
  # Google maps
  acts_as_gmappable :lat => 'latitude', :lon => 'longitude', :check_process => :prevent_geocoding,
                      :address => "gmaps4rails_address", :normalized_address => "normalized_address"

  
  # listing info
  key :LN, String #listing number
  key :TYP, String # property type
  key :LO, String # listing office
  key :LAG, String # listing agent
  key :OFFICE_FORM_NAME, String
  key :LP, Integer # listing price

  # property location info
  key :HSN, String # house number
  key :CP, String # compass point
  key :STR, String # street
  key :STREETSUFFIX, String
  key :CIT, String # city
  key :STATE, String
  key :ZP, String # zip
  key :CNY, String # county
  
  key :CONCATADDRESS, String
  
  # property info
  key :ASF, Integer # approx sq footage
  key :BLT, Integer # year built
  key :DIR, String # directions to property
  key :BR, Integer # num bedrooms
  key :BTH, Float # num baths, in rets format i.e., 2.1
  key :RMS, Integer # num rooms
  key :REMARKS, String
  
  # geo location info
  key :longitude, Float
  key :latitude, Float
  key :normalized_address, String
  key :location, :type => Array, :geo => true, :lat => :latitude, :lng => :longitude
  
  # categorization
  key :tags, Array
  
  #featured
  key :featured, Boolean, :default => false
  key :featured_weight, Integer
      
  timestamps!
  
  # Validations.
  #validates_presence_of :LN
  
  # scope :by_tag,  lambda { |tags| where(:tags => tag) }
  def self.by_tag(tag)
    where(:tags => tag)
  end
  
  def listing_price
  	 self.LP
  end
  
  # unique mls listing number
  def listing_number
  	 self.LN
  end
  
  # concatenate the address values  
  def full_address
    "#{self.HSN} #{self.CP} #{self.STR} #{self.STREETSUFFIX} #{self.CIT} #{self.STATE} #{self.ZP}".squeeze(" ").strip
  end
  
  def prevent_geocoding
      address.blank? || (!lat.blank? && !lon.blank?)
  end
  
  def gmaps4rails_address
	#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
	#self.full_address
	"#{self.HSN} #{self.CP} #{self.STR} #{self.STREETSUFFIX} #{self.CIT} #{self.STATE} #{self.ZP}".squeeze(" ").strip
    #CGI.escape("#{self.HSN} #{self.CP} #{self.STR} #{self.STREETSUFFIX} #{self.CIT} #{self.STATE} #{self.ZP}".squeeze(" ").strip)
    #CGI.escape(self.full_address)
  end
  
  
  	#   A1F: "", A1N: "", A1S: "", A2F: "O", A2N: "ATC", A2S: "22X21", A3F: "", A3N: "", A3S: "", A4F: "", A4N: "", A4S: "", A5F: "", A5N: "", A5S: "", ACR: "", 
	#   ADI: "Y", AGE: "", AIR: "", AML: "", AP1: "", AP2: "", AP3: "", AP4: "", APP: "", APT: "", AR: 25, AREA_Name: "", ASF: 1584, ASM: 204, ASQ: "", AZN: "", 
	#   B2F: "C", B2S: "13X12", B3F: "C", B3S: "10X10", B4F: "", B4S: "", BAG: "", BAS: "", BIM: "", BLT: 1960, BMT: "N", BR: 3, BR1: "", BR2: "", BR3: "", 
	#   BR4: "", BSQ: "", BT1: 0.0, BT2: 0.0, BT3: 0.0, BT4: 0.0, BTH: 2.1, BUT: "", CAA: "", CARS: 1, CIT: "GLENVIEW", CLI: 0, CNY: "COOK", CP: "", CUU: "", 
	#   DBL: "", DID: "", DIR: "Waukegan S of Glenview Rd,to Carriage Hill entry.Take Palmgren Rd to back of complex past gazebo.", DR1: "", DR2: "", DR3: "", 
	#   DRF: "C", DRS: "14X12", E: "", ED: "", EXP: "C,D", EXT: "", FAP: "", FEA: "T", FLN: "", FMT: "", FP: 0, FRF: "", FRS: "", GAR: "", GD: "", GRI: "", 
	#   GS: "LYON E", GSA: "", GSD: 34, GSI: "", HEA: "", HS: "GLENBR", HSD: 225, HSN: 677, HT: "", INF: "", JH: "SPRING", JHD: 34, KTF: "V", KTS: "10X9", 
	#   LAG: 33935, LD: "00/00/0000 00:00:00", LN: 5234778, LND: "", LO: 15406, LOCAT: "", LP: 259000, LRF: "C", LRS: "23X13", LSZ: "", LT: "", MAX: "", MBB: "A", 
	#   MBF: "C", MBS: "15X14", MC: "", MIF: "", MII: "", MIN: "", MK: "", MOD: "2-STORY", MRI: "", MT: "", MXF: "", MXI: "", N: "", NBR_PHOTOS: "", NDK: "", 
	#   NOI: "", OFC: "", OFFICE_FORM_NAME: "Casper-Boyle", OMD: "", ORP: "", OSD: "", OT: "", OTR: "ATC", PAR: "G", PET: "", PHOTOCOUNT: "", PIN: "", PKN: "G", 
	#   PTA: "Y", PTU: "", Park: "", RD: "", 
	#   RMS: 7, RP: 0, RU: "", S: "", SLN: "", ST: "ACTV", STATE: "", STD: "", STO: "", 
	#   STR: "Carriage Hill DR", STREETSUFFIX: "", STY: "", SUB: "CARRIAGE HILL", SUBTPE: "", SUPP_PHOTOS: "", TAE: "", 
	#   TAX: 3885.89, TLA: "", TMF: "", TMU: "", TNU: 127, TO: "", TPC: "T", TPE: "", TXY: 2009, TYP: "AT", UD: "11/12/2010 00:00:00", 
	#   UF1: "", UF2: "", UF3: "", UF4: "", UFE: "", UFL: 1, UN: "", UNT: "", VT: "", WF: "N", ZP: "79054-2603"

 
end
