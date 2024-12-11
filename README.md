# **Express Entry Tracker**  
[![Swift](https://img.shields.io/badge/Swift-5.0-orange)](https://swift.org/)  
[![iOS](https://img.shields.io/badge/iOS-18%2B-blue)](https://developer.apple.com/ios/)  

A personal iOS app that provides detailed insights into the [Express Entry program rounds of invitations](https://www.canada.ca/en/immigration-refugees-citizenship/services/immigrate-canada/express-entry/submit-profile/rounds-invitations.html) and candidate pool distributions.

---

## **Features**
- 📊 **Express Entry Rounds of Invitations**  
  View the latest rounds of invitations, including CRS scores, cutoff dates, and invitation details.
  
- 📈 **CRS Score Distribution**  
  Explore detailed distribution data of candidates in the Express Entry pool.

- 📚 **Custom CRS Pool History**  
  Visualize historical CRS score trends for specific ranges over time.

---

## **Tech Stack**
- **Swift**
- **SwiftUI**
- **Clean Architecture + MVVM**
- **Dependency Injection**
- **Unit Testing**


## **Screenshots**
| **Home Screen**                          | **Candidates Distribution** | **Pool History** |
|------------------------------------------|--------------------------------------------|--------------------------------------------|
| <img src="https://github.com/user-attachments/assets/eba3bcef-d181-4854-919c-ecb78d401219" width="320"> | <img src="https://github.com/user-attachments/assets/fd15f1c4-f10a-44ac-bdd4-e7d58a4b5a87" width="320"> | <img src="https://github.com/user-attachments/assets/7546a0c0-4b43-4f38-bff1-5884b0a7dea4" width="320"> |


---

## **Code Highlights**
### Clean Architecture in Action:
The app is structured with **Clean Architecture** to ensure separation of concerns:
1. **Domain Layer**: Contains `UseCases` like `GetPoolHistoryUseCase` for encapsulating business logic.  
2. **Data Layer**: Implements `Repositories` that fetch and map data from the API to domain models.  
3. **Presentation Layer**: Uses `ViewModels` (with MVVM) for managing UI state.
4. 
