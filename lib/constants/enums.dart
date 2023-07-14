///
/// App Environment type.
///
enum EnvironmentType { development, staging, production }

///
/// Professional Info: Occupation.
///
enum OccupationType {
  professionalService('Professional Service'),
  entrepreneur('Entrepreneur/Own Business'),
  employeePrivate('Employee - Private'),
  employeeGovernment('Employee - Government'),
  nonProfit('Non-Profit'),
  collegeStudent('College Student'),
  schoolStudent('School Student');

  const OccupationType(this.name);
  final String name;
}

///
/// Professional Info: Industry.
///
enum IndustryType {
  agricultureAndAlliedIndustries('Agriculture and Allied Industries'),
  automobiles('Automobiles'),
  autoComponents('Auto Components'),
  aviation('Aviation'),
  appDevelopment('App Development'),
  banking('Banking'),
  biotechnology('Biotechnology'),
  cement('Cement'),
  chemicals('Chemicals'),
  consumerDurables('Consumer Durables'),
  charteredAccountant('Chartered Accountant'),
  companySecretarial('Company Secretarial'),
  defenceManufacturing('Defence Manufacturing'),
  digitalMarketing('Digital Marketing'),
  designerClothingAndAccessories('Designer Clothing & Accessories'),
  eCommerce('E-Commerce'),
  educationAndTraining('Education and Training'),
  electronicsSystemDesignAndManufacturing('Electronics System Design & Manufacturing'),
  engineeringAndCapitalGoods('Engineering and Capital Goods'),
  eventPlanners('Event Planners'),
  financialServices('Financial Services'),
  fmcg('FMCG'),
  gemsAndJewellery('Gems and Jewellery'),
  healthcare('Healthcare'),
  infrastructure('Infrastructure'),
  insurance('Insurance'),
  itAndBPM('IT & BPM'),
  legalProfessional('Legal Professional'),
  manufacturing('Manufacturing'),
  mediaAndEntertainment('Media and Entertainment'),
  medicalDevices('Medical Devices'),
  metalsAndMining('Metals and Mining'),
  msme('MSME'),
  oilAndGas('Oil and Gas'),
  pharmaceuticals('Pharmaceuticals'),
  ports('Ports'),
  power('Power'),
  railways('Railways'),
  realEstate('Real Estate'),
  renewableEnergy('Renewable Energy'),
  retail('Retail'),
  roads('Roads'),
  foodRestaurantKitchen('Food/Restaurant/Kitchen'),
  scienceAndTechnology('Science and Technology'),
  serviceProvider('Service Provider'),
  steel('Steel'),
  telecommunications('Telecommunications'),
  textiles('Textiles'),
  tourismAndHospitality('Tourism and Hospitality'),
  webDesigningAndContent('Web Designing & Content');

  const IndustryType(this.name);
  final String name;
}

///
/// Professional Info: Work nature.
///
enum WorkNatureType {
  service('Service'),
  manufacturing('Manufacturing'),
  wholesaler('Wholesaler'),
  retailer('Retailer'),
  trader('Trader');

  const WorkNatureType(this.name);
  final String name;
}
